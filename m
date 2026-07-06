Return-Path: <stable+bounces-272204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UASkA6abS2pPWwEAu9opvQ
	(envelope-from <stable+bounces-272204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 14:12:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E00571058D
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 14:12:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=a+0XmIjt;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272204-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272204-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 140EE301E4FA
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF38423789;
	Mon,  6 Jul 2026 12:00:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8BF4229DF
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 12:00:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339214; cv=none; b=ozQ4tp1xuKCPFO/hZvp36uvbthRTXa5hAgd4Tmekrz2ujZzZLATU8qoytN583CK6Cf4mJCdXh4Ruiv34AZzfqjfNjnTP6VJxIiN5izg8/BSFWvJesEa0OSedkl4lG/AZS/iVs7PzA0QJafk8Q2/zYYl5Ey3Pvl0duW+rvLDVeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339214; c=relaxed/simple;
	bh=dmuDp7Fv2tAk9iFKwhsczkmrqeRavBEb7VkFUV/pxoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aFNmFva55khLFTW06nbpoBrRIzKyBpfEZyJOP1z3WD9kTMMWN3hX4i7UcfK+Pno57yNUrX5+Lwj3ejXROaKO7jv/0KbdbZy+Elt4NUE8FNi9yG44KxuLASeoR8yFzDFK+LHsAWEYqmE5pnXjbJ71U3DtPmlKxqECU6DoAX7Xxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+0XmIjt; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783339210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmuDp7Fv2tAk9iFKwhsczkmrqeRavBEb7VkFUV/pxoE=;
	b=a+0XmIjtC3f6tOpvV5yFrzJ3pisMRV9g/CNOrwow1t57s6kIHJU8zeK0JxI9UEQNM/h/Lu
	b6OM2UY/q3c3vJFClw8lR2n3QsWh5XOFGYGdIw/WP3/vh5zYWEXpUMdQ7GY7j7zr6miOzq
	m7CNuo9WiChVBHrTxAvhUdarXXXuVn0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-JpE8dzbuOCq9raDZS0k0Lg-1; Mon,
 06 Jul 2026 08:00:07 -0400
X-MC-Unique: JpE8dzbuOCq9raDZS0k0Lg-1
X-Mimecast-MFC-AGG-ID: JpE8dzbuOCq9raDZS0k0Lg_1783339205
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A8D018052DB;
	Mon,  6 Jul 2026 12:00:05 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A11CC1956088;
	Mon,  6 Jul 2026 12:00:03 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  echaudro@redhat.com,
  i.maximets@ovn.org,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: reject oversized nested action attrs
In-Reply-To: <20260706094336.38639-1-manizada@pm.me> (Asim Viladi Oglu
	Manizada's message of "Mon, 06 Jul 2026 09:44:10 +0000")
References: <20260706094336.38639-1-manizada@pm.me>
Date: Mon, 06 Jul 2026 08:00:02 -0400
Message-ID: <f7ttsqc2urh.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-272204-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manizada@pm.me,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aconole@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E00571058D

Asim Viladi Oglu Manizada <manizada@pm.me> writes:

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
> Fixes: a1e64addf3ff ("net: openvswitch: remove misbehaving actions
> length check")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> ---

Thanks for the fix!

Reviewed-by: Aaron Conole <aconole@redhat.com>


