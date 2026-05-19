Return-Path: <stable+bounces-249585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAnDCsxdDGq5gQUAu9opvQ
	(envelope-from <stable+bounces-249585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:55:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E957F1D4
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B94F302B774
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281524EA373;
	Tue, 19 May 2026 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9jLI4eo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82F4DB571
	for <stable@vger.kernel.org>; Tue, 19 May 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194985; cv=pass; b=caekBsig9gyE7TaBrSBX56F8F9okKkW4lEM9KVzeQgouEd4vpj6g/92BNsvy4u8MkF8sQYoddGl2yexexvaEIWxCzxIjLwfw3WQCLHbpfhQUAXom1Ahq3Cl0D37MxE7diKQ2OZoV392240e36iNALUnQ9cbpRUZp7HXZQVyhxR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194985; c=relaxed/simple;
	bh=jfPV2780Bs9BUkpIrmBKLD8IB9nmDhWvo+NzhoVNkFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNdZEWKqD7HNyyHQCMaVh2PbmKCCP71P7ORm6Gb4pAUACknq+kWDlF1n9g50k7A6mLJ5x6JHiZV+n34fpRkDw1/x6Dg92VHrkNi+XkwcR7tTweGqZybpiMHmFlC88Vjue8DMJlvZHZ0BbIr75slakHCF9vB0cga6SiCh/WkGsls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9jLI4eo; arc=pass smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-394095009beso31655871fa.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 05:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779194982; cv=none;
        d=google.com; s=arc-20240605;
        b=G/CXXk49PUG1TTQ/vZTCXLFYZi5MxYvQ1Cbu23WNa3eA70/Q8nn9iDbKjeJeTlhVve
         pskvfYFGNMUUZDvOFcu6hyYZHH9u0zrdlHAiO7wV0o2sF0j9/hVOrAaoDwVub5+DYi/Z
         Cj2w73SAz8Er/ZU4OIWV8i0reIdpPWu2fhj3OqCCQ8UofmUtnyXYSC5wxZEKHbHGqpg6
         a8l/7pbrA5c9xnI5JFYbctWqka4/62pbR+LchQH769VbmYGTVmYDi0sijsCCKsR+4iSp
         fb4/5CbfBvK2ddMy7cNy0SgKeud/Fs9nk3I+dAuof6wdL1FAAXeXW7z1r6G/HKcH1bbL
         FNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TptvFrw7YTp9kcu5BiXjspbxBVKusRMLEntVA9ShJ50=;
        fh=VV6l5FiJwjefZY+oTE593rirryzbN8yKDRliQ2YCSvI=;
        b=VTdspeZnnB6ndRza5kYyfAvg1uIHiJRWmGU+eFDaAlhPciYXNtLrYL22fQUsNIl/EX
         /G7McackYOTgNFc6t7e2PdYq35nR7JLK1ybOir8KlD5hMKMgm6Umr9LNJLxr7U0SIVRW
         5SmMJFydISuYIh4/phgOy/RmrbIqga8gL1CWziSW4f1KPTgTqy8lFaPtsCUjesbIpRke
         IkdqD1qiW1Oykwg958B9jXUXM38k7uXkIyIWwFBR5Hj0wAWWyT+7QAj6SXoPMnPo+ZvU
         t3SAt6IwRSwq349xpRocp4uTlHd/FIpHRTNcBymUQAymohAG51lVLrjVdKtIfMcf8hDk
         I+oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194982; x=1779799782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TptvFrw7YTp9kcu5BiXjspbxBVKusRMLEntVA9ShJ50=;
        b=N9jLI4eo2vECRRoJjR0+xJiwcHFgpCD7gK2ufIuWiULajhYT4zFgikiZ0qzUnJ17mw
         3Kcg8i7wI9c5VBuSiN13PdFTM4OlmVcglvFiJZSd28HuGe6xrMTMr9pl9kQ5/SPnaffr
         a8SOdSzCsVdWgs8ex8529WHQ/kQdCL1L+/Ty98iNgH1fsWoIjObCZ+XqZEaMExjNQnt/
         iwH23AHFfK9+jPKVT4CxT5P2yM64PidlPio0Jw2Kti+1koR3PHhJLYhnEBMm9RstNcn3
         9KzoOKg2BFohCnmcPUt4wnVQz3HH+OmEo2t9JTOATgKfNantgdqs/O2JevFPqbl6NlGj
         pLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194982; x=1779799782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TptvFrw7YTp9kcu5BiXjspbxBVKusRMLEntVA9ShJ50=;
        b=il16HZ7c8cLItj6me8Z/EHK40YE4v57hutwW5GXTwLnwsRcLGZczT/AEgcFczNUlBR
         NjmXsd9WinmCBv2zpE20SeVDk1pzYJ4xavaBJ7QR7iFv/T837Kog4V4GbwX7X4NOgE1y
         kilMw7iiUBnxbGD1kdHK+bPHzP8Kny64JPZOUa5NXzXj6cVC/6Cde6V+0nreG87jqqPI
         WCcLhmiuxXR2L1iRp4NfLrMD/OO0Z2cgftc6crxKFSkF+xsA9YswEBjMR7Gt1zN0jBw8
         BpcOoFvWiueY/327Su8QDHFYEvvRfshGR5MyvpXaCENRc6VZ6+7xwXWbBp0roV2UsxwA
         BkpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LvLc7SJP1P46MJEuwXo8mwRDeRk1Bh3csv+hULzS523LlXb2zDCQLmSvmW9H455ZO7rtgDEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf84UoDllWlt6p6QCYX9MsSatHzdRQ5lxTBX3WlAyyRY0kS3Gj
	GTEPf4uL/sGoy+dnGjdMEFWedXxlQwZPyYfQIWSi6GX0+LZ5qaaDM+qM9GUHGDwE5X8USDOOyyc
	QH94jZ/rMxHJKT1GJBBrMOVDYR0i9t3s=
X-Gm-Gg: Acq92OHjrMUcD67TR4FqwpX6f9nKwC/RsjQ1+nhcHUMkIxHQkJLXsjbHbZl3VvMH36+
	xTMs2oN6gCtt9GzwzZvvYu2a9y9IksTkbc03o0J9BrwVIW4rCCcZBty4Lvd8psfDZ8EQD9QCfbn
	cRta/pCzTK8f5COPe3CR8dWXUDgBRitrxVOvn4/EV3PTvMYwTPmzHJ70/3w49K42QFXzhn7Z40a
	qND/IfWvOS0bcYmCs4YCX3DECkv67oxqMdxSayJVH49F9LYQMwafWKO/CXzjqRSg7/vL1TviSE5
	jbSz6vq5ZzXNQcJ6HcAPa7UAuMeciQ==
X-Received: by 2002:a05:651c:515:b0:393:cb61:1808 with SMTP id
 38308e7fff4ca-39561d2b1a2mr54005981fa.24.1779194982145; Tue, 19 May 2026
 05:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517121626.406516-1-rollkingzzc@gmail.com> <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
In-Reply-To: <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Tue, 19 May 2026 20:49:30 +0800
X-Gm-Features: AVHnY4KBYOwaqhirihEC-ocC8POXVpSAtu8Xd7aeNb3NGD8F1HYlRbpjjVodKoI
Message-ID: <CAB7XQsGe8ZA_WRYcGgkOa--f+XdB6d98_g4VedbFPK01eH0rBw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249585-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8B7E957F1D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

Thanks a lot for the review.

On Tue, May 19, 2026 at 05:32:00AM +0000, John Fastabend wrote:

> Important note here on where this actually happens. It will only
> effect users of BPF programs that are making the push/pop/..
> calls. So most/all users should not be impacted. Agree though lets
> fix this.

Thanks, that makes sense. We will make the impact scope clearer in the
next version.

> To make this easier to read I think having a,
>
> static void sk_msg_clear_elem_copy(struct sk_msg *msg, u32 i, bool copy)
> {
> __clear_bit(i, msg->sg.copy);
> }
>
> is nice to have. Otherwise we get lots of
>
> ```
> sk_msg_clear_elem_copy(..., false)
> ```
>
> Or just direclty call __clear_bit() is also cleaner.
> This is sk_msg_sg_move()?

Agreed. We will clean this up in v3, either by directly clearing the bit
where appropriate or by using a small helper if that makes the move logic
clearer.

> I think we need another fix here,
>
> ```
>            rsge.offset += start - offset;
> ```
>
> Probably carry in another patch. I can do it if you want?
> sk_msg_sg_move()?
>
> I think this is good with small cleanup. The bot report (need to check
> again), but I think it was calling out another issue with a different
> fix/patch needed.
>
> Do you want to follow up with the other couple addons or should I?
>
> Also please add a test for this so we capture it in selftests.

We would like to follow up with a patch series to address this and the
related fixes. We will also do our best to add a selftest for this. We are
not very familiar with the BPF selftest infrastructure yet, but we will
do our best to follow the existing tests.

Thanks again for the guidance.

Thanks,
Zhang Cen

