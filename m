Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDE755176
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGPT4l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGPT4k (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BD21BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB1160E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0B9C433C7;
        Sun, 16 Jul 2023 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537398;
        bh=4ym+ffeZbbAysMpAYUib+nl6+LHdKrRun9IBC/FLrb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/vd078ZfgSx4dAY/Od+M+h5bN8FDNTob/DQMdBp2PtmPBPIh9Fb3UlA8eT5k08Dd
         +4tJ2v63w6QWwdRLKxhWvpYjIrpgujE06Xxfw102n131XUL9iRVu0CF6XKWiXplULl
         GuZFtzUTtytbVpkjJy3hgkQJe4hKLo2uy0kfM4PY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, SeongJae Park <sj@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 081/800] kunit: tool: undo type subscripts for subprocess.Popen
Date:   Sun, 16 Jul 2023 21:38:54 +0200
Message-ID: <20230716194950.988478470@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Latypov <dlatypov@google.com>

[ Upstream commit e30f65c4b3d671115bf2a9d9ef142285387f2aff ]

Writing `subprocess.Popen[str]` requires python 3.9+.
kunit.py has an assertion that the python version is 3.7+, so we should
try to stay backwards compatible.

This conflicts a bit with commit 1da2e6220e11 ("kunit: tool: fix
pre-existing `mypy --strict` errors and update run_checks.py"), since
mypy complains like so
> kunit_kernel.py:95: error: Missing type parameters for generic type "Popen"  [type-arg]

Note: `mypy --strict --python-version 3.7` does not work.

We could annotate each file with comments like
  `# mypy: disable-error-code="type-arg"
but then we might still get nudged to break back-compat in other files.

This patch adds a `mypy.ini` file since it seems like the only way to
disable specific error codes for all our files.

Note: run_checks.py doesn't need to specify `--config_file mypy.ini`,
but I think being explicit is better, particularly since most kernel
devs won't be familiar with how mypy works.

Fixes: 695e26030858 ("kunit: tool: add subscripts for type annotations where appropriate")
Reported-by: SeongJae Park <sj@kernel.org>
Link: https://lore.kernel.org/linux-kselftest/20230501171520.138753-1-sj@kernel.org
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Tested-by: SeongJae Park <sj@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/kunit/kunit_kernel.py | 6 +++---
 tools/testing/kunit/mypy.ini        | 6 ++++++
 tools/testing/kunit/run_checks.py   | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/kunit/mypy.ini

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index f01f941061296..7f648802caf6a 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -92,7 +92,7 @@ class LinuxSourceTreeOperations:
 		if stderr:  # likely only due to build warnings
 			print(stderr.decode())
 
-	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		raise RuntimeError('not implemented!')
 
 
@@ -113,7 +113,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		kconfig.merge_in_entries(base_kunitconfig)
 		return kconfig
 
-	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		kernel_path = os.path.join(build_dir, self._kernel_path)
 		qemu_command = ['qemu-system-' + self._qemu_arch,
 				'-nodefaults',
@@ -142,7 +142,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 		kconfig.merge_in_entries(base_kunitconfig)
 		return kconfig
 
-	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = os.path.join(build_dir, 'linux')
 		params.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
diff --git a/tools/testing/kunit/mypy.ini b/tools/testing/kunit/mypy.ini
new file mode 100644
index 0000000000000..ddd288309efaa
--- /dev/null
+++ b/tools/testing/kunit/mypy.ini
@@ -0,0 +1,6 @@
+[mypy]
+strict = True
+
+# E.g. we can't write subprocess.Popen[str] until Python 3.9+.
+# But kunit.py tries to support Python 3.7+, so let's disable it.
+disable_error_code = type-arg
diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
index 8208c3b3135ef..c6d494ea33739 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -23,7 +23,7 @@ commands: Dict[str, Sequence[str]] = {
 	'kunit_tool_test.py': ['./kunit_tool_test.py'],
 	'kunit smoke test': ['./kunit.py', 'run', '--kunitconfig=lib/kunit', '--build_dir=kunit_run_checks'],
 	'pytype': ['/bin/sh', '-c', 'pytype *.py'],
-	'mypy': ['mypy', '--strict', '--exclude', '_test.py$', '--exclude', 'qemu_configs/', '.'],
+	'mypy': ['mypy', '--config-file', 'mypy.ini', '--exclude', '_test.py$', '--exclude', 'qemu_configs/', '.'],
 }
 
 # The user might not have mypy or pytype installed, skip them if so.
-- 
2.39.2



