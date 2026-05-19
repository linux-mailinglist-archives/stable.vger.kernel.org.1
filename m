Return-Path: <stable+bounces-249676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL3lFhu6DGrdlQUAu9opvQ
	(envelope-from <stable+bounces-249676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:29:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C15842D8
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5B1C30528CA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF63B27D8;
	Tue, 19 May 2026 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOF8vmvh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CF3AEF4E
	for <stable@vger.kernel.org>; Tue, 19 May 2026 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218964; cv=none; b=m4CJtQvFK/rehbkBObhKvMLNGbu2telPD0lTdJl0VnhE8lJybyayRKylB4/pmiRVCwcVbDPBfV0hgF5Jx3sEFcSVrxdMJevhMUjhFttKcnp3iz8LQa2+JrmZ8O+Q+/e/Y9OJoZn2aYMlFKLn/sDx56Q73QWHfA/aYokl+Zr7lwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218964; c=relaxed/simple;
	bh=C5kLjnrt1Psdr44Hr3gwbS4BYyf7hv4DTRM9plgtYY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmrfmpUieBcbOO3PwHQtQ7YIlOcJvS0di+n2AGYq8SIMiwbax0FSRvMNw21Mq7qOdAbRzRtffx1pHDhSxgpF5dO2YY/UdiHT+RRDa5AM56ircZpNMtSbfe/E2/KMx9hrffXGpdFl5oEIKtP3clBq9QHmpZStkNDmTK5wVSerkIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOF8vmvh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7980c060cfso1797894a12.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779218962; x=1779823762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz2Fnig7HtlC1SvcMrAmDqnkwCXWEEDCvrG8zAK6zMQ=;
        b=EOF8vmvhPf93L35q8VnYznAcGFMIbRHpC2+o99GjMsdGT9wbg5HWgrov4laMmXOgqx
         TbwJw8tspvgxB88c+S8+xzdtNyEosBxOI/VRa/jC8rBTh/slo3ok1vR+jheHimdA4JHy
         fhD4kZizuuWylF2TtYRwoW+3r5CTkJoV81wgDPoShvgkWtFQpp6WB0f0PEbBf4wrZTVg
         QxJm+ErJ+QH82BQPqCcEC34PO3uYP4DoxaQmHNM+Css56l80lNY5ugp6odpB/alCv8BG
         gi1TcyQVMz/NT8GS1A9gPLXdjNYXkXCp+6UbtM8/Cso6idkmvb3GbXafSZTGZF1E2AMI
         7pWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218962; x=1779823762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz2Fnig7HtlC1SvcMrAmDqnkwCXWEEDCvrG8zAK6zMQ=;
        b=U8DOcim+RhzxQUnSKYptK54aySKawrFoH3bsnzK6pv+fl5SlrfdDJWyQ1ULaYT6OVh
         kuk/2NazhwVhjgKIpyH9fCQs1svcEO7jO9B3Ig1ZyY3QDd8idzoiH34bM5oINBubR4T/
         qoZziC6Z/s1E9G/7e9CWEUVmGywUtCC3DwQuoRswVzwmElFERcUi55DqtE2IdZiVtkj/
         EFQXfzziejtjtf508eqOgTVjs/MPep7JtZuxUQrSeLs9JtTnsNRN8JsRSGhlqWE5eCEn
         PUZKpH9cDhX5onG7SPvm6tvPACCF0nJhgAL+ga+mzEJlw0UB6OXln9H5dV2aoxMNd1E2
         whkw==
X-Forwarded-Encrypted: i=1; AFNElJ+r665tLpsKzvyKzha/bjK3dgfv9XYUISzcPiyEEYT87OvSpQCcR3dMSZMT8LhdTlXcVGrSmWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLowXVC7H+cfGjbHswt8D6BX5RRqHllF4jC/ughnxq6R8qLCj5
	EGf6RIvNK8GEeNjO6nUDAvRj8YPFlFp7qg7hqSNklDyEGJTYW8ULJbWt
X-Gm-Gg: Acq92OGo07jeRasAWdUp6g6IWvkkBXsgBaBySWxmG/PaIRs9znTUtkxP8gGadP+827f
	vzvqhchhjlKYgY1zornFP5Q1D0u3Wim/FY7EsEdmPgRfKX9HVkKzwmmAEzDe0jmKoFm3AiIhKrE
	DQmRzeVosheoV7NpgEIweYt2GWO4PrfrX8yPDGP4+qYI3UPU4cur73gBsyOK4QnZwl6+FoDoC/2
	EzlwFV2Rb8XNBE+EWUitXQNyKp6KlsBJMycIIAhrd003HeuT88fTOKZl2AqdiT5Z0GMT4taSpcO
	+IZf9kbd5b8nv24l+1ij6ohrzOgMMc3tlD5mXaa9oSxeVHIR3pRftoa9r4ALYDKI0NJU+YYCCe1
	3kBnCrzvt8aYnhYqqnJAp/272jSkO6eRi7vUXpXyni/QfroCWifIcCL7edUw7s9V/Q+ylEORCQm
	kcGRz+7nCdsx0kvwwW7o3K13DhgKNCCiQ=
X-Received: by 2002:a05:6a20:748b:b0:39c:787:f197 with SMTP id adf61e73a8af0-3b22ec70cacmr23131733637.36.1779218961939;
        Tue, 19 May 2026 12:29:21 -0700 (PDT)
Received: from john-p8 ([98.97.43.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb100706sm17626677a12.17.2026.05.19.12.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:29:21 -0700 (PDT)
Date: Tue, 19 May 2026 12:29:18 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cen Zhang <rollkingzzc@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 
	2045gemini@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <rn5uidhakwmnjb4ngkyvzzjnwb573ie35xu34z4fbmlp7spd2o@hr4ifc4lqcj7>
References: <20260517121626.406516-1-rollkingzzc@gmail.com>
 <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
 <CAB7XQsGe8ZA_WRYcGgkOa--f+XdB6d98_g4VedbFPK01eH0rBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAB7XQsGe8ZA_WRYcGgkOa--f+XdB6d98_g4VedbFPK01eH0rBw@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249676-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 229C15842D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 08:49:30PM +0800, Cen Zhang wrote:
>Hi John,
>
>Thanks a lot for the review.
>
>On Tue, May 19, 2026 at 05:32:00AM +0000, John Fastabend wrote:
>
>> Important note here on where this actually happens. It will only
>> effect users of BPF programs that are making the push/pop/..
>> calls. So most/all users should not be impacted. Agree though lets
>> fix this.
>
>Thanks, that makes sense. We will make the impact scope clearer in the
>next version.
>
>> To make this easier to read I think having a,
>>
>> static void sk_msg_clear_elem_copy(struct sk_msg *msg, u32 i, bool copy)
>> {
>> __clear_bit(i, msg->sg.copy);
>> }
>>
>> is nice to have. Otherwise we get lots of
>>
>> ```
>> sk_msg_clear_elem_copy(..., false)
>> ```
>>
>> Or just direclty call __clear_bit() is also cleaner.
>> This is sk_msg_sg_move()?
>
>Agreed. We will clean this up in v3, either by directly clearing the bit
>where appropriate or by using a small helper if that makes the move logic
>clearer.
>
>> I think we need another fix here,
>>
>> ```
>>            rsge.offset += start - offset;
>> ```
>>
>> Probably carry in another patch. I can do it if you want?
>> sk_msg_sg_move()?
>>
>> I think this is good with small cleanup. The bot report (need to check
>> again), but I think it was calling out another issue with a different
>> fix/patch needed.
>>
>> Do you want to follow up with the other couple addons or should I?
>>
>> Also please add a test for this so we capture it in selftests.
>
>We would like to follow up with a patch series to address this and the
>related fixes. We will also do our best to add a selftest for this. We are
>not very familiar with the BPF selftest infrastructure yet, but we will
>do our best to follow the existing tests.
>
>Thanks again for the guidance.

Great. I think its fine to address the tools extra callouts in a follow
on PR if you want. If it helps get this merged sooner lets do that. All
the tooling keeps hitting this and we have lots of duplicate reports.

>
>Thanks,
>Zhang Cen

