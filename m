Return-Path: <stable+bounces-223433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD4BEIxurGmxpgEAu9opvQ
	(envelope-from <stable+bounces-223433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 19:29:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9978822D3CA
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 19:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8578230209EB
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A436C9CE;
	Sat,  7 Mar 2026 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=valentine.burley@collabora.com header.b="d/qfmH4G"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FF287507;
	Sat,  7 Mar 2026 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772908168; cv=pass; b=aRaNwh0bKSu6PbluGioNWnzwtFzr8h4xsv2MqGP/6Bagl++iidGWf7j5zsCFAJYZB9wgWL/wQuyKfFyUZY5A/j69fDVAiqm0HtVLo2G4rLeX+54B+PQj/ds/CT+yPV6XHSeA5bBY2KYuJ5LWUFtzcw6N+TYHkgDVq6UdMRHUcfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772908168; c=relaxed/simple;
	bh=XLeYu5sp8xAqiIpYP1ao+++AXATt6m9XQqufu06SvEA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HaMSFKHsrmCC8i5zbhK9q01LOU4w7ZufriEBU1ZLGrg/8ktpZnzTee+o+5bv8VVUJUt5RAryAoqbRFuIOT9pj+LhX2EESBivSYd3Sjw6DsYU2KEibMraRUs1PK6m54l1MzzCsZpKbyz+8xkoyaTsOIMvi3qWi0GQGZ+SJl3AQZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=valentine.burley@collabora.com header.b=d/qfmH4G; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772908147; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GsdMfGCfoLoSf6FDErk0QF9+yrbJ4gjm2iXg9rKJxwKsxZsIfwyKes6Z8HVi93mWTCtzw1HI5zmbCj85Me4AViOL2e7blEDnfxYnov/HcFvnWPIfj7Vj5kwawDsVdgQNgBegNl3ljPqglaR+T8YLYYthJxov/W5qTX4Nh0SLDug=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772908147; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=otNb12BkuMueEPdITPyW6N2Bsr+BtWR55FBBzFloQOw=; 
	b=KcPvHuWovV2BH7dgtj7hy3SSTGvIllj9yDm46s3ohzY4NSnv3ABfUtNjdcuA6RNegUvriuPCk1ZUkJUftS9STfKQzh0CC+N+YiEideMV3bNCerS8wnMLcdo1bigzN/YUkXXvBMxX+rAFXL2HkONV4hWl/WH33BvghiF1vvakvdA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=valentine.burley@collabora.com;
	dmarc=pass header.from=<valentine.burley@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772908147;
	s=zohomail; d=collabora.com; i=valentine.burley@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=otNb12BkuMueEPdITPyW6N2Bsr+BtWR55FBBzFloQOw=;
	b=d/qfmH4GoZ+5Bgd+uq1JU/lSAY8AYqx2XMxE6jZLgdHg6Fsin9gG7o4O11WXCbR8
	Y0JyPrQ3ytC1DCyBevcHFCxbUXQTr5vSxPcwG/iVJPo4ClDjCtOhp93dCUDP5wseIBs
	BN4Ozs7WQj+5kLftUvd+p90Y+FfUZBCZB30ZQKek=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1772908145625135.82383304834843; Sat, 7 Mar 2026 10:29:05 -0800 (PST)
Date: Sat, 07 Mar 2026 19:29:05 +0100
From: Valentine Burley <valentine.burley@collabora.com>
To: "Marc Zyngier" <maz@kernel.org>
Cc: "tabba" <tabba@google.com>, "broonie" <broonie@kernel.org>,
	"stable" <stable@vger.kernel.org>, "oupton" <oupton@kernel.org>,
	"joey.gouly" <joey.gouly@arm.com>,
	"suzuki.poulose" <suzuki.poulose@arm.com>,
	"yuzenghui" <yuzenghui@huawei.com>,
	"catalin.marinas" <catalin.marinas@arm.com>,
	"will" <will@kernel.org>,
	"Sascha.Bischoff" <Sascha.Bischoff@arm.com>,
	"sebott" <sebott@redhat.com>,
	"linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm" <kvmarm@lists.linux.dev>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19cc98f6bc6.30a0020a4990004.9101239855762576863@collabora.com>
In-Reply-To: <871phveh17.wl-maz@kernel.org>
References: <20260307115955.369455-1-valentine.burley@collabora.com> <871phveh17.wl-maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Skip interrupts in LRs during EOIcount
 replay
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Rspamd-Queue-Id: 9978822D3CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223433-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[valentine.burley@collabora.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,collabora.com:dkim,collabora.com:email,collabora.com:mid]
X-Rspamd-Action: no action

Hi Marc,

Thanks a lot for your reply.

On Sat, 07 Mar 2026 17:33:08 +0100  Marc Zyngier <maz@kernel.org> wrote
 > I can't reproduce it locally, but in a crap integration, where the GIC
 > is clocked at a few dozen MHz, this is far more likely to happen. I
 > should dig that Lazor out of the bin and put it back in the test rig.
 > 
 > In retrospect, it is obvious. I just couldn't see it until then. Many
 > thanks for going the extra mile and pointing out the core issue.

Appreciate the clarification!

We also have a few Lazor boards in our CI, and the Trogdors are indeed
legendary for hitting all kinds of edge cases.

<snip>

 > Could you please give the hack below a go on your setup? It seems to
 > work for me, but given that I never observed the issue the first
 > place...

I've tested this on my sc7180 Trogdor setup, and it completely 
resolves the issue. The Cuttlefish VM now boots reliably.

Tested-by: Valentine Burley <valentine.burley@collabora.com>

Many thanks for the quick solution!

Best regards,
Valentine

