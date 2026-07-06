Return-Path: <stable+bounces-272201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NiR8In6YS2rfWAEAu9opvQ
	(envelope-from <stable+bounces-272201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 13:58:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D29097102B6
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 13:58:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=C3Yo7znj;
	dkim=pass header.d=redhat.com header.s=google header.b=jKu58+bi;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272201-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272201-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BACE302D32C
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F7A41F7DB;
	Mon,  6 Jul 2026 11:49:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005B41D4DF
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 11:49:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338566; cv=none; b=UhBcE5A+nU8TCHyFZkL6ph+NeNDiqWshIlehicBuS0/mSYn5zCOpULz1Ds3oja9pK+qkFEeGUKqfQ4bU7GqyyW4KcSEVMKfEuhiwFfhnN970+11nvcxkPdfDaRK9MwtvZLZtvwsB2NEcWGA+uDaXjJJZMmNzeYGyMZzFBOa5kF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338566; c=relaxed/simple;
	bh=ej669tqdQRBrUGwoO+9YEmnfZjZOl4s5UHB7MEdZfF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8YakVNAvDIKi40XyXGfVGBp0IH5Y9Ap24K2oGruozSzoNXqe/O68O4L95F0kr0Nj7hgjGFtSc/jDs3VX8nMSMCwgTJ8D5pWM82w5iOTBc3FJMGN4Z1MwkqUze84Scw0xql/eUrewr0aSOYyrkTnQwR6qvUC5jENJl+dfWkEyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3Yo7znj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKu58+bi; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783338563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ej669tqdQRBrUGwoO+9YEmnfZjZOl4s5UHB7MEdZfF4=;
	b=C3Yo7znj9rV/se1ONNNfWcm2V2hXPau2tIiHJJlsV9xtXzFdsAjCGkmXelI08kRnHhem1K
	gZhlg6dFFXDI+Q5zQEXzkVSjMlsPKg36Nu+BJ6xh8xn5+jftDBWJKfa2LS1/yF+HdKOnCF
	FHsvR/BW1yldIzIA0tzO2ZWGrVfQk4Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-EZfZSozYOI6HYJraXNqagg-1; Mon, 06 Jul 2026 07:49:22 -0400
X-MC-Unique: EZfZSozYOI6HYJraXNqagg-1
X-Mimecast-MFC-AGG-ID: EZfZSozYOI6HYJraXNqagg_1783338561
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bf481a6e4e6so198807666b.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 04:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783338561; x=1783943361; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ej669tqdQRBrUGwoO+9YEmnfZjZOl4s5UHB7MEdZfF4=;
        b=jKu58+bi/uwSZJhHtAswirNFDHNTG28+UPWscDa00BiRC7d5scqZP1EtXla+kYGCWS
         O4ZJQqATXO7pw7wpvntlsf/A4cLYt4gA+f1SSjPXKa1wm0Hpsd8fWfvEOmmjC9QTHVEl
         fvRfQqGfgItMK7folGDSv0RKt2dGIj1g/9uB0HIcfDLKz7AG3G/KJdP41oPXfW0G1ZF0
         EjTtc6yTVHIMIHvZxXLfepbsTwUMvQ5LDmEHAOuS7Q4PO8yKRNNJIA7yC8hQvprXUIyf
         Nh21TjKiWzq/BGM5gQY/356lgURGZ7LnTvxc8c4ZK0TVQZsdAe7DARxjJJAtZu1jBsxZ
         u5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783338561; x=1783943361;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ej669tqdQRBrUGwoO+9YEmnfZjZOl4s5UHB7MEdZfF4=;
        b=EMZD1OyD3gqpayrlCaU6r5RIDMtMGloRO06brz/8ppbzH1gHIcJ+0UcsQiI1uVNPkF
         o/ZW4hABCmImXIZDHpAbYLw0M3cxuUe2R4qHa/BkFzyDm/tfydSlAk09z4BJqCWavijP
         WVBEYwGnioV+ViwHj8p9rdq/VMQXx9emJmRMO5NzfC2DOXI0Rdaswgu9VZoiF7a6DBY0
         OGYcRJ1MlW0kfwFSVJq5AxmeUsl6kbHGjmUQMBBbNsZhwYc0Q5svPZ1CvuWgMr6zEHBT
         B+aaptDMeheB+eIUutnKYzfD7WvoqSlHLLS3k38v+HAlwRv77QMZPkGC2nC+vX3jusc0
         804w==
X-Forwarded-Encrypted: i=1; AHgh+RreQ3mv6a6SctNX844XM1cE/Pc7pGM6c4ABd45iQTlCu5zFSm2QeDovwdfom0yPeTuyYI68S8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+wyDmAMxwkFUkqahGc1oZOQi6CYVUeTAAYDbQoQ+wb949f1X
	mG+/tw0By6KSR7IZmczDWWtrBRfcsYTe3tpdOf5D7UUVi8/+eTaNYF00X/9KexWSFc58gaSlZgD
	rlFLgSGjthKJK5fFlKSx3Pj4X8ngN0BqWi73soTN8bh1eIH/G8UezGR5p6Q==
X-Gm-Gg: AfdE7ckMsfMwlj4vkjazwPZVnw/ct+lCcLRxNpaZSmAgUqn1mhPExEG14LTXkHC3EOM
	vEaEBiHscP5vI15GsfXP75RG1P1odnMCuClTJShxfKsVpU++KJWhcigaNzdsqCYpjhOZIlDfB80
	zYzfq5mU66E6fjibDaqfnR6TweIBGFN+MwmbgWcTZhfc/1WLF9H4DRGEtNWW0qSj4AJcyw9k997
	oSxt8qyp2KVhJ0DDnfUIlfSqYVi3FFxAcgrK/KO5v28OuJ+1m36sLoQOKPTwegkMDVNbdWf2SfB
	4vANG5GOBmUcu1rNJHzcPGBiEjyJlju3GJU5s611lDKYF+r0LoSgA/wiKJ8cnB+z9e05EEbn3tr
	mvqJ7KsIpuV4FOR/iPm1Yh6DlHxrs71/1PFlUAgiYbGGiij93rEx/Vxxxpi0=
X-Received: by 2002:a17:907:399b:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c15a67dcb6amr12179266b.6.1783338561106;
        Mon, 06 Jul 2026 04:49:21 -0700 (PDT)
X-Received: by 2002:a17:907:399b:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c15a67dcb6amr12177866b.6.1783338560626;
        Mon, 06 Jul 2026 04:49:20 -0700 (PDT)
Received: from [10.44.49.24] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b628c16fsm752234066b.37.2026.07.06.04.49.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:49:20 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: reject oversized nested action
 attrs
Date: Mon, 06 Jul 2026 13:49:17 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <EECA04B1-CDC4-4902-9DF3-4DE93515E6EF@redhat.com>
In-Reply-To: <20260706094336.38639-1-manizada@pm.me>
References: <20260706094336.38639-1-manizada@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272201-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[echaudro@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:manizada@pm.me,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:aconole@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D29097102B6



On 6 Jul 2026, at 11:44, Asim Viladi Oglu Manizada wrote:

> Open vSwitch stores generated flow actions as nlattrs, whose nla_len
> field is u16. Commit a1e64addf3ff ("net: openvswitch: remove
> misbehaving actions length check") allowed the total sw_flow_actions
> stream to grow beyond 64 KiB, which is valid, but also removed the last
> guard preventing a generated nested action attribute from exceeding
> U16_MAX.
>
> An oversized generated container can thus be closed with a truncated
> nla_len. A later dump or teardown then walks a structurally different
> stream than the one that was validated. In particular, an oversized
> nested CLONE/CT action may cause subsequent bytes in the generated
> stream to be interpreted as independent actions.
>
> Keep the larger total-action-stream behavior, but make nested action
> close reject generated containers that do not fit in nla_len, and return
> the error through all callers. For recursive SAMPLE, CLONE, DEC_TTL, and
> CHECK_PKT_LEN builders, trim resource-owning action-list tails in reverse
> construction order before discarding failed wrappers, so resources copied
> into the rejected tails are released before the wrappers are removed.
>
> Most failed outer wrappers are discarded by truncating actions_len after
> child resources have been released. CHECK_PKT_LEN also trims its parent
> after branch resources are gone. SET/TUNNEL close failures unwind their
> known tun_dst ownership directly, and SET_TO_MASKED has no external
> ownership and truncates on close failure.
>
> Fixes: a1e64addf3ff ("net: openvswitch: remove misbehaving actions length check")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>

Thanks Asim for the patch, and Ilya for the offline review.

The changes look good to me.

Reviewed-by: Eelco Chaudron <echaudro@redhat.com>


