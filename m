Return-Path: <stable+bounces-274182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D6E6CrP7VWqGxQAAu9opvQ
	(envelope-from <stable+bounces-274182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:04:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A5752A95
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:04:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=djxYHHrk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274182-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274182-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C163E3023517
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0F43B6E1;
	Tue, 14 Jul 2026 09:04:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5214426ED3
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:04:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019880; cv=pass; b=DCuCRriqq2JVfsvhPkwaAQLgH/BHbt/ENwVdbRRuNFJghiG9XxHTEAATcpxxO1QVSOIC7sUHJRUYuidRCPjLpGb02mL9REgwuSN/08yk5WTZkkfTalxX/oD/7AJUSjgk3Y4tjkkb86kliiRVmkRTNTB4njA+7wJjfSf92cQ/bdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019880; c=relaxed/simple;
	bh=iaQmmVCiE7NdWy753PwYNnwaKukj8zYSbeXA4Z5zlkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ5/nRrqYgY8X8nwSaBYJ3YbU4ODXymEG+C7o2HAZPgoMr+mktCi7NXEJXAvtGhpTFdQXYrHE/bxAl12EHYzkTpIkg6aEdj7OPBZV4OTbBJZuIDAU8CPuDj0CiUlr0wmA9yZU+Sx8/6S48wTniArJjyCpXwiRBw6T7lT8DOnNdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=djxYHHrk; arc=pass smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c2a449c57so33588951cf.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 02:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784019878; cv=none;
        d=google.com; s=arc-20260327;
        b=Ha0dRjPNMFzkWTQSNcCpo/HywzdnFuA77KAZjzarAMdWex/KahDjdDAUUroPEnbZEX
         tfjzEvzCG+a4dt4hQMfGVvNO1Ue2ZNwKwM8XbaSj/svVNE7u4DqAFtG8HM38dpz1NVFT
         LO1Kq9c8+fK+FF5Z5CjsJaw93fmWobXp+NM170bkfuv6E4qhT+jPTSMecESvDrgZsyhs
         i+w1cNEIMVVuhcl+GTfIFQlanR7dhGJcE4BLuuUqJDgpkwrHz4pLwhvYqxw5qOMpj1r/
         nh9V2toij0VxAvxtiElN1lfdp4mBJ8VbZBcP1X/me3NsEJP7SYH3Aq5zk/Wv8mPrNlQK
         dYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZTtUNxO6z9f4mwqOUjyr9bIYNiAKbPXuXL1XYYWBu4=;
        fh=6OtQz/PWZWMR5X5VnVJfB76n2A8lO3FW/URxqJWHjXw=;
        b=UFhyeXF0OHuPZCEPGAsRZ9UuqKVqbje1noCWv0ihpLMBLoY91hPalNd6cKDDbLb8oE
         2UYHUMnbqF11AhBId8s9QXCPSani+cIQ9Xp6ZNNWxbXnbr2WKEYI3Th2sH8GbZJGlfPG
         06T3YXWrtN85Zs0AXzw1dYsrEryzY5kxluwT2YgS+L2USAAG+X5jes1Ex96cyHaGTUnv
         QluASuHEbwVFb3hhscLDwDCwexY9q1nV9vEwm4HTQ04RCOuJdQSVbwByjBNuJ+yC/7SY
         vehX8g3/dbwF/DpFiLHGwpPE8/67ObDj1IrvV+VwvJTLSuR7Ihi03WqjXbo4Oi76PhvH
         yIDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784019878; x=1784624678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XZTtUNxO6z9f4mwqOUjyr9bIYNiAKbPXuXL1XYYWBu4=;
        b=djxYHHrkjcgPgG7FwxC2dKlRb010Re0sfYlj5GUrAxkc//RLUzPHU9O2a1MnNWxRD2
         JBixs7jPtAnau8tL1SxG2Rj/wUsl6sLyLvKpiis9jCKXstJK4m6/93+0BDzMQn2h7eaS
         4ErGB30lWwyL6TFHuB6j4NcVBBnYtGIHvch85romvZIjDeaSrnYOBnoQE5vRc1nDJcMy
         sNkVKGkGRd0aN6WWwMattICCPl3f3Z3IGiKVaAHh9nNagzvXss7RRvYszvgJMqOeO8EC
         ue6c7d5ufHW5BZdjLgWhWWlBxqfhmOvcD1uY/4E4+oGlvzWk6SUW9l2xUsCvhAgubskC
         DUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019878; x=1784624678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZTtUNxO6z9f4mwqOUjyr9bIYNiAKbPXuXL1XYYWBu4=;
        b=k37zxOYLE3ivRuPVUtQhse4NKp3SZAsuV2yC2YFxuyeW0BcD9iD7WiWSbtt23c09Lq
         Jl2yvNQ1ld7idiwGZ+o6DtfUD9LfmzGA1a5oEPD5sZvmkC/H97Urd69loMtF3q6XIfhQ
         F1FikvdI4nmULGL5cpwp7YLKus3UmHh08/AhqJl1dVW/L8mf8cTxwzu1px5XbxMA9eAh
         a9kmxrDj+aaQjofqsNKSfinK3ADPVWamm+VeMyk+hi12dTp96y/8tv10Fa1TL8Zu9GGu
         vKvBw8E7Md7ZwiEFeIY6idoQ4nZmqXXljUsZikqkltkvQ45RXyse5PM9pWuR9DIIaRbV
         NgSw==
X-Forwarded-Encrypted: i=1; AHgh+Rqp7QCi9A+ttCdRAtvw6YVor4mKneb8w8YryILkYAnhuZ0oSdJiSYIzlvMRq2Ds2O1hqywOYto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPqgnRbcf0Itc6PuDmX+c456OjXkKXktVxDe8VIV6C50ByGj7
	qz4z5HEYp5LlghP4RRNipq40S+JE6S9ZYUxNDpuZ+txO7TYf4FU8UtL9vdp+PNgn3xt9CwU0ML5
	1Ty1Zor5RWxQzTA7kmI+cHsF9jHV3pbZuqY/CrZiJ
X-Gm-Gg: AfdE7clNVEzTzo1WbQoBX9s9WDNyYrVMyknciHnIx2nKfsjNS7jwj9/m3WGu9qKKqeW
	TccpRNRFEVbPKKiExZfNPUnRm5M+Uuw3cj6cIhzMEgANew3zquzwb1BV1efP9huIauG6l0XOtEU
	G4FfOiGFQzWqxKhblWPw4wXfENf9Bw/2oIS+9dZNYy/AxByiUkzd7kyRF9vLwddfYIN116APiDY
	iSp664OJ0JUW98moIsWD0EVaRnwO3bGXuXVRvlHSh7sqfyDfh1NJHVql9VoND9rUSNe75FtvkUS
	/tSfjMH2qh6t4JIWgDIanPib5RAQYRRz/EoWLhdjwaPhniFOP37fDohRzF+MvBQZwRumi3cB+gn
	XIZGI/HhFHpw=
X-Received: by 2002:a05:622a:11d2:b0:51c:e14:87ae with SMTP id
 d75a77b69052e-51e3c1d28d6mr27490681cf.34.1784019877100; Tue, 14 Jul 2026
 02:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713105631.8616-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260713105631.8616-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jul 2026 11:04:19 +0200
X-Gm-Features: AVVi8Cdwh5_lQBrDRf_glhh8Szsib8QIaD1yn44tVc0VeL-V8w9Ji-fQmVY1sNQ
Message-ID: <CANn89iJo9U6TQbu3aVcn2YY=2CGTTf8+CAhwYh4i9EyG8cnayg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: initialize standalone TCP-AO response padding
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274182-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A09A5752A95

On Mon, Jul 13, 2026 at 12:56=E2=80=AFPM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> tcp_v4_send_ack() and tcp_v6_send_response() construct standalone TCP
> responses with TCP-AO options.  The option length carries the actual MAC
> length, but the TCP header length includes the option rounded up to a
> four-byte boundary.
>
> tcp_ao_hash_hdr() writes the MAC only.  Thus, when the MAC length is not
> four-byte aligned, the one to three bytes after the MAC are left
> uninitialized and may be transmitted.  For the normal TCP-AO hashing
> mode, those bytes also have to be initialized before computing the MAC.
>
> Initialize only the alignment padding in the TCP-AO branches, before
> hashing the header.  Use TCPOPT_NOP, as in the normal TCP-AO output path.
> This avoids adding work to non-AO TCP responses while preserving a valid
> authenticated header.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

