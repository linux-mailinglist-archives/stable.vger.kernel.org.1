Return-Path: <stable+bounces-217721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IxLLWswnGkKAgQAu9opvQ
	(envelope-from <stable+bounces-217721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:48:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC8B1751B7
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 441F3302F425
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88E35CB60;
	Mon, 23 Feb 2026 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="uEYmNzuJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB71E9B1A
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843686; cv=pass; b=G2wzulmLg1abhaC2AoTH4O03BsAGbYyf8z8Obj+yoNyelmkyrfz2+0SJGU1YMtf3Hq6w8WYy+8Y/7HIt12egZw5XBXaxsov930lL8DVkY0WWrujnZW1NSGkjih5oqF/Gdlkymp1QuwN0l9RWwVQ2yIQ9J4fSREi3u1mElvRizyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843686; c=relaxed/simple;
	bh=QeOEsVeZ9klcyMYyvytk/qdh3OHqWAZ7aYcxi8/K3XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOCilfWLO6qKF05Z5WnvyoS3kaxhkKK5mWoenGNzhcgcTj/rBPPo2qf0hwjkgC+YwleXMUrMiderJbGZxC9xXP2auFEyjNhqZBwKulqyUvP0P3YRp1GxZ8FfC2Z26UElBuftVxIccXxwr7SbwAuC5nRgsT+OdPFSk8Xty7dbcIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=uEYmNzuJ; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79802e2c989so35280487b3.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 02:48:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771843684; cv=none;
        d=google.com; s=arc-20240605;
        b=TTURvQmBf1DW2MjaSHO7d6UZaH3F7PIdlDdtO2vwM+EpP/8RsKJUn+Oc2j7Deg5be8
         tls2jv21dK9NPjn6gaOuBFLGOmrGPt/jGWJ2NuDDoXI8wyUNCmceZhD2iQGSsU1VAKR7
         Fa98AiVZHu4tW0A/AXd3vndQPSmlIxmxcGtic6IBI+LShF4O+1jaE75myCVBvGIZCLtQ
         uSquf940JOmVy49q8ceNXvSwy/mlY+nypKOpL60piy5iBrXO5SIpFObO6XiMe52qJqk9
         /Qb4g7kID1KLIzieUnxldftqLcGNaZVQj5+p9C7+7/Pifosby8GDZ6gCz47mw5dcRfcJ
         oaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QeOEsVeZ9klcyMYyvytk/qdh3OHqWAZ7aYcxi8/K3XE=;
        fh=UgMciDhuX4md55bQQnjFuqEnbbZZQO8eqWVUVfd52IQ=;
        b=N8GeCB3y4WL9Hk9knbIZbM+YgkIx3fUATyydWVnj9siHFU8SehZK+zu+VFS4ks++jx
         U4nSuupzBLqAaYPkfbZIsNCzm5++Ofn+/bLobtsSgavlJMm062hCyLreaWBkZ91ulzzQ
         Y4ruucmZUUKMkD2QcNhuKb3ESgSV6CsaVQ5jsuYNrZ7LRg+9gyUXEltVD6w90FMNYrj2
         vGHSX20D9pnW2vrfSa6dtfnDo/Lbo5t9inK9S/4gtne1NT2M+AyGTrJxD/FQC9SNBQRd
         go8cLxYtaH6R3nLElPfNBnExRImJM7xExsGGequiIvyc77gWJZUZcZjhuazohyBqwpP7
         Z0Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771843684; x=1772448484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeOEsVeZ9klcyMYyvytk/qdh3OHqWAZ7aYcxi8/K3XE=;
        b=uEYmNzuJY4E+XG0xNDwub7CZrdrz5mdQdGFj34mvZciM20yomwImwvSEvREaXl/dvF
         MV539F98fR12mVfG9nAUq0i3SdziKJ3sXYX/pNCuXgruLrP7lDMInwpDcXSLtdb/KkNj
         o1l90GPlEoc+ixPNF9BYHiR/ZvFCXqIVcG72MjAwqHLKPpHOAsl6Umsn1hlBMBwGp2PW
         GcgkmS0DgycEUZARJ3WZCczfDvWNMcMIgL56Lkln5avhdmJ0ALJg6Xa5jcVOBPZ2X3tY
         7sKFpJMc1XhOqn30q3mUE0YL3TAMzpw6aNmRWypNR1KXo7Ds4guYJJm98Ar/hmB5TmVx
         57yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771843684; x=1772448484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QeOEsVeZ9klcyMYyvytk/qdh3OHqWAZ7aYcxi8/K3XE=;
        b=RXzCncfr5H3Mk80hKFPRjFIQry1o+7xRu2BuJ2RSFXoBe1UwcrHhCB6GkXS+z3Mo5x
         R+EDLVyjIjQAvePxHKgVJ2HCR6mK5wRsCrcYUVBunvhWws6kGsDYlShA1PNcQfbBCdBv
         2M98HZV95oX47x/YeI0H7zBBo+ggfjClyY//BDKSUxszI6rgNAxqhR5Jbw1xO13f40bi
         UPBBGe6Mw9jps0Fgx5df2j+uY/yEtVaaRSp0nKnfwxueD0z8dEvF5RhY3thunZBybpVu
         VEsVCJKDP3qZbIUUWf6JslzwCzkUKHJj3eZOOVnRAKtgT7O+6UiM4cXBLCCDu5qlCOPN
         nmBw==
X-Forwarded-Encrypted: i=1; AJvYcCUYRTawwbIa6s1uVOvbSjY0akrBfYIbVkLHu+9bO/b5qFgr6Fgq/bVDyiAyjIo8F6mS4RYbwwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuuk7SkxksdOcds8CsFpoUAu/ntaiNA6JnjCr1K8cE8nqimKh
	IHXl6ipKb6UCXpT+QbumvoyXLDjsg5k+UhWiMEoutZhA7j/PX/m7mSRdg2MrCj85/rY0EjnUWXM
	8Kj4WPpl9m1ibSO2XyUVRDYIjKrLXIXlWtt4f96Qs
X-Gm-Gg: ATEYQzwrKDKzaJS4HJmYBHU+yVuE7ZIxkqaQdevmbwNUYKCr8ITZTROg+NhLi3KpVKV
	QMWb1duExy/zHJCRC/9Hjbxymu6CynsATLJ+CCn6+LFjoyEP2rnPn+h5vfSFz1dUayuF1WMMR43
	mFYyVaZrUS0yCi/xta7/ERMt4v8LP8pmCanrfZ6qlcKjP0XQehElnshkVLO0fcaEM5iJvZejuN+
	EmWxeOGlG5pMLsC7XiT4Mq9q7Ar2SRtOT6SOAUm3YJF8abaJ5MR1yFX9+VbiFSDHQDgu8V+xUJO
	+GjiqWE+7k5eKCcqVcloyQ==
X-Received: by 2002:a05:690e:1384:b0:64a:e89b:d7de with SMTP id
 956f58d0204a3-64c78e58eaemr6997011d50.81.1771843684150; Mon, 23 Feb 2026
 02:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219023151.171753-1-p@1g4.org> <20260219023151.171753-2-p@1g4.org>
 <CA+NMeC-WmxL48X5dSqGx5+2T_dR8B_g5C2BL2Hre_HG1-UkXDg@mail.gmail.com> <TtHh0X2fAHdo4Gs6voxOjI5iFT3kt9qJkutxcHLc3nSpal0RiOTy6cXeZ4FSJMRcD2qVJy__ER-pvJhgBhbj9qucVu5yNecJfCeD44HmtBE=@1g4.org>
In-Reply-To: <TtHh0X2fAHdo4Gs6voxOjI5iFT3kt9qJkutxcHLc3nSpal0RiOTy6cXeZ4FSJMRcD2qVJy__ER-pvJhgBhbj9qucVu5yNecJfCeD44HmtBE=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 23 Feb 2026 07:47:53 -0300
X-Gm-Features: AaiRm51lJFg7e79JKgjG7OsGqAzPtwaoRLqJDtGC59XuuJVeJI19kMnYrJ4iZt8
Message-ID: <CA+NMeC9mYweb=uPTugHhmjK26zSgA8qmKM0OJ22jsJZHak8SwA@mail.gmail.com>
Subject: Re: [PATCH net v7 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217721-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2BC8B1751B7
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 11:13=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> Yes, I only see it as unreachable code cleanup.
>
> While looking at cycletime, should I move that block before
> spin_lock_bh()?

I think it would be best to leave it as is and just do the
unreachable code cleanup.

cheers,
Victor

