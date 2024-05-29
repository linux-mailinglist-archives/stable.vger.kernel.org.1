Return-Path: <stable+bounces-47644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFCC8D3A89
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8831C23470
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12B117DE0D;
	Wed, 29 May 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cnY3VuUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6FC746E
	for <stable@vger.kernel.org>; Wed, 29 May 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995865; cv=none; b=KlFpjmgDCM8FRK6FP2Cz9RSBuYmKIu9vSAk8kjjDo7D4LJ5aXbCGA41yS1TvgiLf2uzCm8r/ZrV1fjZkYAkaAWSMDmTVlMX3D4k+cWtXivCkNLNonsN9wzmdzlGi0YC0JSV1jCufh9cBBpPNP70sgliKm2wK45NpzZfNDigHBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995865; c=relaxed/simple;
	bh=10ZbkJFlzOmoHO7F8XCv1L13FAm67CbtlCR58DmGhSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PCx73vBXmJcMwIITGcuoLfa6QJgSrzZDVVrDaDEyjfj3Yt00nXDkuLGqPI4PM+gFQC96I+FdWmKe/UHMIs3OPLUBUWEVidqCA2ZLesy2e68E+gqA3FG5Y6aNhrd9YxKUBr+j0cKrXutMjo7JkpmHg8TYzLZD9t5njTMtoUt54WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cnY3VuUt; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 679B43F772;
	Wed, 29 May 2024 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716995853;
	bh=hgoyK6HeoTNKyWJml+Y19SRjb3UaSAKeC/4AfSQtwbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=cnY3VuUtbNIFrFeE4blgX/OpMrU2IgMaoMGuj5hHxAPKBbkothYymS1MfecfSfBkW
	 lrptf4ztqqcmha5NO4WmIQ+oB4fPl9zaQ0l8bO+iU4r+8DHjzDmCxWOpVgOmeWEUVt
	 A/pZTGK2GiHiK1itXcV4tQOVXd6SwHfPxZd4euhpOBe6w8T05Yr58u5vcCoW5WYGv/
	 bLine5uRVT2F4DUPAprCpcMFlW/0Q3gLswGYwBjxITBplGdLbdw0RHGWm9+lxyvn7y
	 +OC1IngIlITIW6YflxsH7fidLhHoSJQQ7iYsQWXntkx6GJyluucCJ8HVMNmAqx5cRk
	 CSwNwKy8W8DhQ==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	po-hsu.lin@canonical.com
Subject: [PATCH 6.6.y 0/4] Fix missing net_helper.sh for net/udpgro_fwd.sh test
Date: Wed, 29 May 2024 23:15:59 +0800
Message-Id: <20240529151603.204106-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since upstream commit 4acffb66 "selftests: net: explicitly wait for
listener ready", the net_helper.sh from commit 3bdd9fd2 "selftests/net:
synchronize udpgro tests' tx and rx connection" will be needed.

Otherwise selftests/net/udpgro_fwd.sh will complain about:
$ sudo ./udpgro_fwd.sh
./udpgro_fwd.sh: line 4: net_helper.sh: No such file or directory
IPv4
No GRO   ./udpgro_fwd.sh: line 134: wait_local_port_listen: command not found

Patch "selftests/net: synchronize udpgro tests' tx and rx connection" adds
the missing net_helper.sh. Context adjustment is needed for applying this
patch, as the BPF_FILE is different in 6.6.y

Patch "selftests: net: Remove executable bits from library scripts" fixes
the script permission.

Patch "selftests: net: included needed helper in the install targets" and
"selftests: net: List helper scripts in TEST_FILES Makefile variable" will
add this helper to the Makefile and fix the installation, lib.sh needs to
be ignored for them.

Benjamin Poirier (2):
  selftests: net: Remove executable bits from library scripts
  selftests: net: List helper scripts in TEST_FILES Makefile variable

Lucas Karpinski (1):
  selftests/net: synchronize udpgro tests' tx and rx connection

Paolo Abeni (1):
  selftests: net: included needed helper in the install targets

 tools/testing/selftests/net/Makefile          |  4 ++--
 tools/testing/selftests/net/net_helper.sh     | 22 ++++++++++++++++++++++
 tools/testing/selftests/net/setup_loopback.sh |  0
 tools/testing/selftests/net/udpgro.sh         | 13 ++++++-------
 tools/testing/selftests/net/udpgro_bench.sh   |  5 +++--
 tools/testing/selftests/net/udpgro_frglist.sh |  5 +++--
 6 files changed, 36 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/net/net_helper.sh
 mode change 100755 => 100644 tools/testing/selftests/net/setup_loopback.sh

-- 
2.7.4


