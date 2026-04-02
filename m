Return-Path: <stable+bounces-232984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJSTOVhUzmmEmwYAu9opvQ
	(envelope-from <stable+bounces-232984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:34:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 836283885FA
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40F6230F4D7D
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85DC3CBE90;
	Thu,  2 Apr 2026 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE5veiJF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D93BE634
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129203; cv=none; b=FIHHQeNCYGSo2L3n6Zv6Y38S8KWheMXMqgUyo5UScJdCeDgJL9qZVzGp8MRxg/cu3QVNzGFI9lCNPz/XT8e/jIhhFIvH4ihbnv+G8BIwzYRymUXQCHxQ+DmrqPQoFHVZTl7el6ToyA0GCYUJwLEvdHh5ZGqvA0MnanLwJTg6i4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129203; c=relaxed/simple;
	bh=UFFlTW70THGmSkqg6ywoWIx/uIQmxDePKuS13kjxt+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk/cATpuATmrBbeofVHJKENz+VIWmE1L9ODy361gn4lVUWs8sqkjcGhYKx92josyh+JqHfiWN4ngKxNRRmiHAFlA5L2sreYjdbvSApe5GXsFAqFhsZ616uq1Iz61IyEfRH5+yiTy1T0r0IJU3NaeguZDvooANvjYjOZ3rKzH4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE5veiJF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76b95e652bso230159a12.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775129190; x=1775733990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngNHrZ3nxHjFo/kuGGH7BAmeQWcRuG1lwtVJUVhp3dI=;
        b=bE5veiJFXeirlDNbj8dziljyEZtfpUo+hlNnRPDyrimRySDaf7OFceXOKFSAodvmja
         2jUF/peSab3Y2iGfXVp6IjytRgo8Fvi5Al/mCy3WxjsTbTY4AxNswvdiKCakLhoiV+v3
         h8nsvKhYFkxP9BNYUukccDjDM2yPl8WENK6/AxTj+HFA8L5VpejHxjnBYpVLwllhaGmt
         wlQSZs4h36j+K79VJtBoG4ZeWLJMDqZ/ZUPMFA1ettkzpKf23Yni/KUp5f1r3t5GUDxG
         E/ggTYYudNVEJkQ+de+0c0oXOpXknoV8hDg2i/bQshySazwjm940ntMmNrOyl0K7k6g7
         eG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775129190; x=1775733990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngNHrZ3nxHjFo/kuGGH7BAmeQWcRuG1lwtVJUVhp3dI=;
        b=stIkRR4lxqCyxgGKQSxt1XO9GcZWDaUznp67kFWQftXXhBTSd+6aIyIUsdaBagxgAw
         IuMIM5aYQgdbz23RZvKBq0oV8yDTTGyWJazhKaumvLncsl2sSfmZ3COMH55tr1hQE7/Q
         qa3Kbuwf5kV3JsXtT3IIuMk9oqWfTFkjjLXAep9UpjIW1acQWEG08sFDf8V+uWUQkj1r
         59oOuNCoGbmQ0Flnp8Vd2vw78TG2Thtvk0psEivfePxfnIzo5wBQByDgD8BshenoKJjY
         gftOdzG9kMqP2mzLmciX8Hp3hBmkYRTVW+Fp9guAmBJZxcsG2ZsnxrgPbzY0eeduWXfo
         7nrg==
X-Forwarded-Encrypted: i=1; AJvYcCXOkZtfl69eIzp8f76ZGvA94ABcwkQxHrCSdSnZdBF6vjMIAG/hyKa/t9MW2Lp1TWqWp54BbCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxexMjr81jBKCJDs9X40dRk0mIOM/WMyhtyRo7U4sbNd3xqgyxH
	V4tS9VIeYnCR6AEYw/cfSR1i+eJVzuGM+4XPjqQWASMdZC7ucQqhZnvk
X-Gm-Gg: AeBDiet4ikQOAiyORuluxL9snv3rKRDamAGNQytYIrEhMU0ir3I4AUoyZ9Fw3uDKWqa
	lCWPY9ccEHhHDyDGy8AytSOEaCg0JFmYWjIPn0Ij1GOkFH7X58/tk+rMpcXF5WvBVjAaF5XxGzp
	/JhGN9P8AHpUuSHNuVgt1oTPISdP8bzigX7yfJmCvjXvQsdgAyQlt4DvApAh1PwtlluPjfolAU0
	x+Ejz2FDtr/amzYUyg3J1Ip1ubW96UNlM3bBIMUvErvIXi/s4i6ol6b4lz+/WNCFBk3aReru+gf
	CIrF17eaFgIRdd8Dhgos4lFKC4uAPf6fHdUUwTrAL0+vlGklBOA22xFJzVfAx5Q0AVm8rRnsDuG
	GYtFzOxxLcZ4TzMr6RTF/JmaUnQnW0oCEP2g1UpRzF+f71lOuELRP/zzZ6ejM7/uMHbKYpiULxa
	zCjeyTAgKbiiLST0JWu8zNDjlAPhUFVnsxUFc=
X-Received: by 2002:a17:902:f545:b0:2b2:5035:dc3a with SMTP id d9443c01a7336-2b269caa770mr68842155ad.42.1775129190366;
        Thu, 02 Apr 2026 04:26:30 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cdc61sm25977135ad.80.2026.04.02.04.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:26:29 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH v2] xfrm: delay dev_put in xfrm_input to after transport reinject
Date: Thu,  2 Apr 2026 19:26:20 +0800
Message-ID: <20260402112620.57920-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ac5K7S3dBsINFafg@strlen.de>
References: <ac5K7S3dBsINFafg@strlen.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232984-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 836283885FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 3, 2026, Florian Westphal wrote:
> I'd suggest do drop the refcount after NF_HOOK, i.e. something like:
>
> dev = skb->dev;
>
> NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
> ...
> if (async)
>         dev_put(dev);

Much cleaner. The reinject callback only uses cb->net (saved at
queue time) and dst_input, neither needs skb->dev, so the ref
only has to survive through the NF_HOOK call.

Will send v3 with this approach.

Qi Tang

