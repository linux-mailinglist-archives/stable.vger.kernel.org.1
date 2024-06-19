Return-Path: <stable+bounces-53803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BB490E72B
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85358B210AA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ACC80638;
	Wed, 19 Jun 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="g2r2ZwQr"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2B7E0E8
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790004; cv=none; b=PWcFnEWYJ14bw3z2N+cIjRWtpFf33NnVcDQD5V/IfbRROtTrJJRtqgKgD5b9xS8D8Vu3f+LvPI8+x46GYdd4jvYd6MQJw+gbSWcldeT03aS7N2uojGZ2vUqWbRTw+PVsr8qEIUwQjwrI6YCTbcfeYHlEvWti1myA/HhigU4qHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790004; c=relaxed/simple;
	bh=x0BtClZhmI9vZ8QDuN1sb1729/FtYwXEey1cuUtDnC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kXtOZT2MNsRn2vMnq2C3JvsffLHWDmUnwoaoZP9S+yQIS85n/FWAJmhFGrGn5dPQd0n8sco3w14KotXFVa4GKWNbdnWDaEW9mZxKgCDxc0c4j3d12IzuG6Qcu+t8KTAIeWsy136Wa3oSy4e7nZRrG5XxsEU+w5QIpR9zEyBetH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=g2r2ZwQr; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 642CE3F120;
	Wed, 19 Jun 2024 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718789994;
	bh=J++EwvyHgR6bSSBrMjtPHE1gyMy7f8gToQJFV5x+ZCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=g2r2ZwQrtReQdC0/WBY2TSk8mdIMCfBCFLvRoJ1NgmgWZ6Jsu6Qaxj/ZQaMW4dfjU
	 BAATh8P5/9di1CxkvVDs7f7VFMNRlv8S73L+m29Tw25WGxKd+vqPYdUnL7rCx6iiTo
	 7Z6v0SmKldlnS7COBIxfpiEdQEvPVtMtBkD8duM1jMN84oCclFUXHDn3sDiU04hyKT
	 2i9D/PQODgiYZISyl8F53EXIjsszpxeJD2UODn5kNPFkJm5jxOy5peg84qdGtv29Vs
	 PV1M9I2sTDPDuJ/+CrOKDhZuO/3GHUB6qOdl55TKmRIJJ/eA0Tsr2hKLnOb9L1iU3S
	 y9VWqbx1WhkPQ==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: po-hsu.lin@canonical.com,
	gregkh@linuxfoundation.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	bpoirier@nvidia.com,
	idosch@nvidia.com
Subject: [PATCHv3 6.6.y 0/3] Fix missing lib.sh for net/unicast_extensions.sh and net/pmtu.sh tests
Date: Wed, 19 Jun 2024 17:39:21 +0800
Message-Id: <20240619093924.1291623-1-po-hsu.lin@canonical.com>
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

And 2114e833 "selftests: forwarding: Avoid failures to source net/lib.sh" is
a follow-up fix for tests inside the net/forwarding directory.

V2: Add 2114e833 "selftests: forwarding: Avoid failures to source net/lib.sh"
    as suggested by Hangbin Liu.
V3: Adjust commit 25ae948b to add lib.sh directly to TEST_FILES in Makefile,
    as we already have upstream commit 06efafd8 that would make this change
    landed in 6.6.y.

Benjamin Poirier (1):
  selftests: forwarding: Avoid failures to source net/lib.sh

Hangbin Liu (2):
  selftests/net: add lib.sh
  selftests/net: add variable NS_LIST for lib.sh

 tools/testing/selftests/net/Makefile          |  2 +-
 tools/testing/selftests/net/forwarding/lib.sh | 52 +++++++--------
 tools/testing/selftests/net/lib.sh            | 93 +++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib.sh

-- 
2.7.4


