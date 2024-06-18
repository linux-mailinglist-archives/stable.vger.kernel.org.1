Return-Path: <stable+bounces-52641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2648090C685
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4891C21A92
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E10F13E022;
	Tue, 18 Jun 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="REC75KeA"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887B413D501
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697222; cv=none; b=mr6Gu4hev0TyD9TlpbDSwAgVvvDrBiG7qbkofxqJmKJtQZ8gZxdXUfsQrAKthahTfCrjD62SAJgjS2UUGV8A9f2jo2JYyFFajGXrw/XV/hpCkJWY7rSYhJsUolnkJUcfhqllbo82jrzyQPLrqYtvNcB3JjiWo6zjO6tvciQM82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697222; c=relaxed/simple;
	bh=2LwSOIGC1ffHQStQEQs/uedPkNN/oOjnkhNsDbZzJhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8p4hNgQ+9NZDfsBe8GvQxKsuW0jKSZqodtN/x4Lp7ita2NRuMBP+DFAXczTcr9QZfti+scXqcxB1p+FALAEJNVYU9yA+z7A+syHkI/JduBp6iPKujjSsP1FQwW5sLzPpUpsSUmhaWhndNkmViCxPdAiiocyktVTYtDYzJaGvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=REC75KeA; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BB3283F070;
	Tue, 18 Jun 2024 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718697211;
	bh=wmEE7Ea2T/aVyONqgvGOmVO7bc+oLOOOUkWNC2xGYVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=REC75KeAZTLqsv/jj2Xc1exaYOy8BojWUdmeKf+cVCkTGaoBBI4uMZoJMjYgo5x1+
	 4X8OOsTLsuZh8FVYeW7OwUcw/7oQxIjGP9i3D/rADlO5m8e0w4x6uhRs+Ln/eXj3jd
	 QNiRfMTzEs41p/U5JeQuQJ1LoKkKTKdrTpDfn+yUw30xQKzFuKv+sp6OqJWZaH25ru
	 LrP5pqZ2nTXcrEFRgoCMKZdgAf+rzL/ByBPR9gz5rzL+8wEaWY7FGXZQ07jleVc6Ed
	 W6o8vIf+zRWIn+TDyZWU2tshbo3PbBpxuuq2533qZwS998Pw1fe3E6WPdpQjt6S0PT
	 dd6RMdj2B168A==
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
Subject: [PATCHv2 6.6.y 0/3] Fix missing lib.sh for net/unicast_extensions.sh and net/pmtu.sh tests
Date: Tue, 18 Jun 2024 15:53:03 +0800
Message-Id: <20240618075306.1073405-1-po-hsu.lin@canonical.com>
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


