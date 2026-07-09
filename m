Return-Path: <stable+bounces-272890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0EeHLZqNT2orjgIAu9opvQ
	(envelope-from <stable+bounces-272890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:01:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF24730C2B
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:01:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OhWhagHe;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272890-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272890-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC7623015C0F
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA923FFAA4;
	Thu,  9 Jul 2026 12:00:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51A31F996
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:00:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598418; cv=none; b=PkMRFILpvwcmvtrscVW0044vI0tGcTQtRCd2ObBu4RThX8zQys9yKoMtHMUIjKGQZ0VtsY3Eb6w55/sVCBHmUMdv5xdOGbF+y71KJ9/xl6wTQianufySfxioZ7gZ0MHhu5AmkLTm1hQRE0DtW7h0HwRE6HLJSguqIxP0KJrx7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598418; c=relaxed/simple;
	bh=cSBdc8BBnyRLpnjMSu1QpbPrJfE3jILuuYEAXMRbwwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehVytVfLZLDYKgJZhF3bCCtLGLz/xTcLPXjL2j05tZSIrQ1jWzjOgJ9VJf93KGWcw29Ga2OlIyM+DU7Nykh+x4f2Sr7+dXkJQ3CDu82wY+4Trk1VaKqpnytYd79Llk2tQ9nZ4bLB2jiayOuun7HmOcG9IjgbWJy1VZE+hci/z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhWhagHe; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783598411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSBdc8BBnyRLpnjMSu1QpbPrJfE3jILuuYEAXMRbwwc=;
	b=OhWhagHeu96z0MJuMdt7agz+bxOh+peN7WNADpIO+v4ATTPY45OarwzrOT0HGZ4xt/JdUv
	YfVrcxmCfZzvI689PEoOasOSXyODpI4itIHnYW8MG2WMO19sJX2yKDyBFIDIWJEZ2pReiv
	43CWiTI57jMqQhrZa8deQ0KKweUO4eg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-HEB2ZsPFO62fGRwxLukiSA-1; Thu,
 09 Jul 2026 08:00:07 -0400
X-MC-Unique: HEB2ZsPFO62fGRwxLukiSA-1
X-Mimecast-MFC-AGG-ID: HEB2ZsPFO62fGRwxLukiSA_1783598406
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDD40195607B;
	Thu,  9 Jul 2026 12:00:06 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC8FF180035F;
	Thu,  9 Jul 2026 12:00:05 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  stable@vger.kernel.org
Subject: Re: [PATCH net] openvswitch: fix GSO userspace truncation underflow
In-Reply-To: <20260707221635.27489-1-kylebot@openai.com> (Kyle Zeng's message
	of "Tue, 7 Jul 2026 15:16:35 -0700")
References: <20260707221635.27489-1-kylebot@openai.com>
Date: Thu, 09 Jul 2026 08:00:04 -0400
Message-ID: <f7t33xstltn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272890-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:netdev@vger.kernel.org,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aconole@redhat.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[stable.vger.kernel.org:query timed out,kylebot.openai.com:query timed out,aconole@redhat.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,openai.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CF24730C2B

Kyle Zeng <kylebot@openai.com> writes:

> OVS_ACTION_ATTR_TRUNC currently stores a delta from the original skb
> length in OVS_CB(skb)->cutlen. When a later userspace action segments a
> GSO skb, queue_gso_packets() reuses that delta for each smaller segment.
> A segment can then reach queue_userspace_packet() with cutlen greater
> than skb->len, underflowing the length passed to skb_zerocopy().
>
> Store the maximum preserved length instead and bound each consumer
> against the current skb length. Use U32_MAX as the no-truncation
> sentinel so the value remains valid if skb geometry changes before a
> consumer handles it.
>
> Fixes: f2a4d086ed4c ("openvswitch: Add packet truncation support.")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


