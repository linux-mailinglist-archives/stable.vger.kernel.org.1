Return-Path: <stable+bounces-52145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E24908416
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F64328278F
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 06:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5C1487C3;
	Fri, 14 Jun 2024 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Vx1ZygzM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35541148313
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348337; cv=none; b=E82UxQHX17r1zA9wzRYAA+ayaY/aYT2FQ0ILrkvL1fUhw+79kVoH/1aDysMkobWSzPcx3xfyiKLxFOc8eGcJ+P+wDC4uq1hKt2px7YmLKXkiPjjM4i9RssJ8t0j03HW4YlED7yze9BTu75tWILblCOBLHXRlX84MRHUt7AMuqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348337; c=relaxed/simple;
	bh=qszL1L9c9EbOMOylJ0VdwBE243cH1tkr3ICnjarkhyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dBfr8xXgpxYD50pmYILzDhIOI13gD0df+OlB3z4tN86lxA93lX980TWU949XDjli3MOb6VaHx8cSBgjEK2aE4feS3N2vpNAOzotd+SwymyouajJjmoYgXJJJedmvy6J+exEqA9IiM4z2mNg2vA3DGMANDfcjmYBwdvLo/rWDAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Vx1ZygzM; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 474063F951;
	Fri, 14 Jun 2024 06:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718348326;
	bh=S0teeVlKmglVvcuyioyx9alD3K35oMO/MjwpirH5oXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Vx1ZygzMuDFq8bDip2vEz0eO967rdFEAlX65BsMSVGXcTeSjohm/z/2ADaLixMYTk
	 MVkx1OFlc2EyZeokz5gMLxSQf+7pQQMhv2MUWX8oT+MoXHXrgB/sKxJ3W351aDBBTS
	 FBCHFIHKHQdk+xtoMWiTOuXGVM3/8hz7nl2kqRrldWc6uY5UIfjgRfu/ab3Kwb+N7v
	 xkUbrmy3ws63MCmtSAejblaftg0cq0LV2hFvUmOaUCtQ9Bigj5uw4ewuwcDDysz4oo
	 dF+mDRvK5wy5a61LYYCUjB2Lkcd4Cg4G+O24a9s98sgtKhkTAF7Tty2HbaQpaB5q4R
	 kj2qUqxRC/quQ==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: po-hsu.lin@canonical.com,
	gregkh@linuxfoundation.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	pabeni@redhat.com,
	kuba@kernel.org
Subject: [PATCH 6.6.y 0/2] Fix missing lib.sh for net/unicast_extensions.sh and net/pmtu.sh tests
Date: Fri, 14 Jun 2024 14:58:18 +0800
Message-Id: <20240614065820.865974-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since upstream commit:
  * 0f4765d0 "selftests/net: convert unicast_extensions.sh to run it in
    unique namespace"
  * 378f082e "selftests/net: convert pmtu.sh to run it in unique namespace"

The lib.sh from commit 25ae948b "selftests/net: add lib.sh" will be needed.
Otherwise these test will complain about missing files and fail:
$ sudo ./unicast_extensions.sh
./unicast_extensions.sh: line 31: lib.sh: No such file or directory
...

$ sudo ./pmtu.sh
./pmtu.sh: line 201: lib.sh: No such file or directory
./pmtu.sh: line 941: cleanup_all_ns: command not found
...

Another commit b6925b4e "selftests/net: add variable NS_LIST for lib.sh" is
needed to add support for the cleanup_all_ns above.

Hangbin Liu (2):
  selftests/net: add lib.sh
  selftests/net: add variable NS_LIST for lib.sh

 tools/testing/selftests/net/Makefile          |  2 +-
 tools/testing/selftests/net/forwarding/lib.sh | 27 +-------
 tools/testing/selftests/net/lib.sh            | 93 +++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib.sh

-- 
2.7.4


