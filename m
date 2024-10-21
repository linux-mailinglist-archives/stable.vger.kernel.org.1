Return-Path: <stable+bounces-87096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E29A6305
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7100E1C21AC9
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8F1E5037;
	Mon, 21 Oct 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1WhUwIKG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C361E47B4;
	Mon, 21 Oct 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506581; cv=none; b=AQnv17wprwyNTFcRZkZ7bbcW0NRhZTHU6RL01mwXHQ0bCVQ5UzxG5/6S+M7UypmyYPKwED+1CVvnK+qZ284EKQdryuUcPPagNHTlOcojnvYLo62kAx/G9OWvAmeE9NtXlaJhAHIoQcUmso9Fwf4XonfxkIs4rdvaiCqnGettxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506581; c=relaxed/simple;
	bh=wPqXME0dt7z+ev/x4/CSfcBN2vedcggMoQRRqOFLMHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/+Ftoj0wzBNOBvKu6TA7LCyz+ObQ8UbrW41AxHLTcq8j0iEvaFRaSVmZFPbx8D6ZHxdixQCEv3Q+Kw7CNALsCw2KkmrLBFvwiUgSfz0NicOgFARfObkzga/0viUE51hEUEZusgkSep8NeiDZHi32R8FakIS74qrJbrfz6V2OZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1WhUwIKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09998C4CEC3;
	Mon, 21 Oct 2024 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729506581;
	bh=wPqXME0dt7z+ev/x4/CSfcBN2vedcggMoQRRqOFLMHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1WhUwIKGVV/huJH1NwqIVSdZHdJA+c6bVJESpQ8V8rvbs49gZb+rN0itLKmEID8vF
	 BYCE7ACrj0/uoVELBTVPhl4Np9DWbo3uYtMW8a56S8GHZu4KF9oF3iy2w7ecfDvNRW
	 2rF9ZG8tOW7AbzpYYjxhGOwgV1kwBz91ubET3IaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yun Lu <luyun@kylinos.cn>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 6.11 053/135] selftest: hid: add the missing tests directory
Date: Mon, 21 Oct 2024 12:23:29 +0200
Message-ID: <20241021102301.405403513@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
References: <20241021102259.324175287@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yun Lu <luyun@kylinos.cn>

commit fe05c40ca9c18cfdb003f639a30fc78a7ab49519 upstream.

Commit 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")
has added the run-hid-tools-tests.sh script for it to be installed, but
I forgot to add the tests directory together.

If running the test case without the tests directory,  will results in
the following error message:

    make -C tools/testing/selftests/ TARGETS=hid install \
	    INSTALL_PATH=$KSFT_INSTALL_PATH
    cd $KSFT_INSTALL_PATH
    ./run_kselftest.sh -t hid:hid-core.sh

  /usr/lib/python3.11/site-packages/_pytest/config/__init__.py:331: PluggyTeardownRaisedWarning: A plugin raised an exception during an old-style hookwrapper teardown.
  Plugin: helpconfig, Hook: pytest_cmdline_parse
  UsageError: usage: __main__.py [options] [file_or_dir] [file_or_dir] [...]
  __main__.py: error: unrecognized arguments: --udevd
    inifile: None
    rootdir: /root/linux/kselftest_install/hid

In fact, the run-hid-tools-tests.sh script uses the scripts in the tests
directory to run tests. The tests directory also needs to be added to be
installed.

Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
Cc: stable@vger.kernel.org
Signed-off-by: Yun Lu <luyun@kylinos.cn>
Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/hid/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -18,6 +18,7 @@ TEST_PROGS += hid-usb_crash.sh
 TEST_PROGS += hid-wacom.sh
 
 TEST_FILES := run-hid-tools-tests.sh
+TEST_FILES += tests
 
 CXX ?= $(CROSS_COMPILE)g++
 



