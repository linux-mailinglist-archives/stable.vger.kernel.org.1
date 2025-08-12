Return-Path: <stable+bounces-167242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D057B22E25
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439D11767D0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4962FDC5A;
	Tue, 12 Aug 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCxYeuE6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C052FDC3D
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016904; cv=none; b=aWGLsseY9qL386KNs+SMCjdAVc9NHZxuf/NegJr0OfYMtRbBhaDTPHwmCGVsHCKvQZY+wy1g/jjxr+YU3FgvQS1Ds5lwjKXpZ6zKbVAVXmAgCRftvQt3ggeXCOKwwRxxL3S1BAHnB75v5hsy7uOvei4ftAtibwDSVdTFhxJsT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016904; c=relaxed/simple;
	bh=uixkoVe93YmyiYCM76IKFBIcTu5CvuZ1gi74Tm6iQkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4dMdraCZB0siGUumn2lyBILblTbxgGi4iB+qCzF+++Ac+29ClGDrC5Wm1dYBLvvOTI8nqqMOZa5wDSprRviEq8JdDhVd7oBZDNGnO1DsXi9bA1+foGEf4XdPFa84qk4sg8PPUno5bTOt3+xaBavF6rqFvsUWPAn81rWXXBzFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCxYeuE6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755016902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tA79BwHA37ev4oyAiF4sUQX7XYHdN9weXPtGACv/i5c=;
	b=BCxYeuE6mg2RYeQyade9YUE+bZli6WUv2VGT8TgYzs14vG/KtKYez+f0ptaiiOSwyC6wF9
	q1Im7OW1auuhjpV4hoXeKHTsz1wVhvvVccnI2Hb9o8KnmdziJu/Iq2dQ5BWDALGgwwrSBj
	96zLYH3DuPVIDTVbPi6q79J4HIh0nck=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-h1YBYPexOM2RCWxsdCuYDQ-1; Tue,
 12 Aug 2025 12:41:39 -0400
X-MC-Unique: h1YBYPexOM2RCWxsdCuYDQ-1
X-Mimecast-MFC-AGG-ID: h1YBYPexOM2RCWxsdCuYDQ_1755016897
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B67CF1956096;
	Tue, 12 Aug 2025 16:41:36 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.32.60])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC4E0195608F;
	Tue, 12 Aug 2025 16:41:31 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lion Ackermann <nnamrec@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org,
	Ivan Vecera <ivecera@redhat.com>,
	Li Shuang <shuali@redhat.com>
Cc: stable@vger.kernel.org
Subject: [PATCH net v2 0/2] ets: use old 'nbands' while purging unused classes
Date: Tue, 12 Aug 2025 18:40:28 +0200
Message-ID: <cover.1755016081.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

- patch 1/2 fixes a NULL dereference in the control path of sch_ets qdisc
- patch 2/2 extends kselftests to verify effectiveness of the above fix

Changes since v1:
 - added a kselftest (thanks Victor) 

Davide Caratti (2):
  net/sched: ets: use old 'nbands' while purging unused classes
  selftests: net/forwarding: test purge of active DWRR classes

 net/sched/sch_ets.c                                   | 11 ++++++-----
 tools/testing/selftests/net/forwarding/sch_ets.sh     |  1 +
 .../testing/selftests/net/forwarding/sch_ets_tests.sh |  8 ++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.47.0


