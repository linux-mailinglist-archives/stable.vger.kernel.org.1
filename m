Return-Path: <stable+bounces-224713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIQJGJyVsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:17:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC19C2672F4
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3A6305144B
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666153DF00E;
	Wed, 11 Mar 2026 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NpS4JDaO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD312E7F0A
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245553; cv=none; b=cP/jOe0MxLimW8Hj+eGqOR082cPKxePu6F/O52z1W5V5/4GABfBsuGp02ldt9q0HSTdbzCBPhXp0fyryoJuUPsBDoGDpbzvXAyNLdMpZJmlK+mbLWnH4+u90YKPwa3oeCPsWL4nwN50nAaXNOz0f0xe6DhP4+zC1DF7OcXionbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245553; c=relaxed/simple;
	bh=zXYXilJ1hbpmx1D0Zw4urqw9JRsY74/33FC8/lHVvyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxxxYquUBWQFvaJZoot4WtTOzaic1EBn19LCEoaHkpNz9V0syL4OyCn6aJDiS29iiTE4rNJYrTZqznrmz/+WFourxNVpDqPhoSgKMfRKXrp7AknxH/FfJfXsI+MUqZ9qegl5cRPX+PGA8AQQsh0kkLnmgH5kEDQXbcd27iKtVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NpS4JDaO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso265425e9.0
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773245550; x=1773850350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdb8PCOlgls8g32Eovg/NZwMsiR9gdwY/Koklz9SGq4=;
        b=NpS4JDaOYTxNLZiFp74OfaZ70nTgcl2rQPeeXzdKH/EQZ1Ou0e5p2SLWqzge07fF8t
         ZzEUT8kEo976YKW+VESyBZrPBvEZEavX90VUz0adtGKp85PgWH7LAReZw8w1avvt3yWy
         HldWjcu53yGHR5CpruJkl5T0MwYFI1WYmUJ+7Lj8g8ln4JPSWca08Y4ZOC9MM+QB5+Hz
         8SR5MJwFAwrXCVjcvr6jvLcy2wDns6MD2Gi04DmlqeDw0005Y7o3t521LmFEgwNF65rO
         4LNwJs9KqoPsFwO4sWcMg4hhQaWlPWhhPk0RRp9OezITPWIvPwru8Ns3LD7w42M+knvM
         K+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245550; x=1773850350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdb8PCOlgls8g32Eovg/NZwMsiR9gdwY/Koklz9SGq4=;
        b=HOK3OJ6/4KiK98hXexxhExsu2AbbPo7RAVfIVQ7FQlE2kTezeXfd/dB1ZmqJhxsE8N
         MNgTUyzpgTbU1qKTitQ9baG4HaNmj4HXZjVfYNXyG0pellqybYtFvK6CiA5SVMAllYHh
         vFdomHsDqCEgIenPetrnjIFlKBOyGvg8+Xzz+Vw9LNRxVWg+Eyd7nWMSixAOk7LkVTrL
         +LIGRZEHaVn/l6GNJgCe6sYEsCRuncqEwgQJ7Q9PVUfEfGQlLDI0poeZzIRYbXyuwahq
         6mTkKM4WR79mM3hlcGluvcUF2FBj7j0G1LHenRzMnUAyxlgqwwpgtk1Yo9K2xDw/SKK5
         LxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnC74sLoZZz5Hb2DuuAkFWCgk2SrZ1ou7Ww67+81NP4TsYENGKXLtRp3HOVbz15mBN/JqUwKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgWPAlpT+h8KsRVncLVVBAq3f8sDQUR/0ckm3VfEKF+zILbfw
	a/MV/2zrEKPVD54hnrq9jxTJnCUzx1Ia7DreTjvhRIVUKnk95a38hOrzC3S6ZdH3Sv8=
X-Gm-Gg: ATEYQzzS1MDcEnJU6dZRJhZropwFFj/zXo1HqPhc5ojNBCwzInKYEVre9A+3WZgTFrW
	5B6GjCSMMPxzJ9nUizYldYbothrjtaiyHW8aMLXx34JbIDCcH+Tpi4wCFe1SAnBsX5cGGgSaBUP
	CYEmFUhPRzHj0axvpXuBfbIlLyt73Rr0kNyi/hEDxbJCV1dlwRuvHqYOhwMfu5OGZKD1rP2n0KE
	CzxqwoD+fwS8n2DHh81BxRRezjtsaS0Mx1Xm0V3Knvx+gE1i4BOuahLzNLRrQ0c0CFVGHBVq3Ge
	zcmds6IelsFTEe9a8b8FomkYtMD6JgjFjPgo0XVSuFMZ5Qp/lbwMSXiLlPAtFtZp4v9icpm5/Wt
	Pc6posmT6G0lbtbkiukC8N3LGfFVSoaNQQQHnD2l6njeDSJZSkm7AEbeN6AS9PpJpXtUOnEs/Sg
	mfbToSStUTt6BVSl0Wh9zqiaeA2NkhaCGAwritMZYKh6CNYZCmYHRMWW4=
X-Received: by 2002:a05:600c:8715:b0:485:3f1c:d8a1 with SMTP id 5b1f17b1804b1-4854b0b327fmr55640975e9.9.1773245550008;
        Wed, 11 Mar 2026 09:12:30 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7c1780bsm3380311c88.7.2026.03.11.09.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:12:29 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:12:25 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Cc: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] failure to reconnect on SMB server restart with
 custom TCP port (not 445): Host is down (at least since 6.6.95)
Message-ID: <lbexcljami5n73cz7oevuarmcvwbchtolcvlx27w376lparasj@kcfy45dkgt7g>
References: <20260310235642.6d9798f4@plasteblaster>
 <c66p7dr6vlujvnwczbnrmqx7monkdgdnm4rwewm76aibn7jza3@d3uik74dei72>
 <20260311091653.358b213a@plasteblaster>
 <20260311094836.5ba141a3@plasteblaster>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311094836.5ba141a3@plasteblaster>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224713-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC19C2672F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:48:36AM +0100, Dr. Thomas Orgis wrote:
> Am Wed, 11 Mar 2026 09:16:53 +0100
> schrieb "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>:
> 
> > Do you need a confirmation with 7.0.0-rc3? I guess the picture is clear
> > enough as-is. I've started a build and can give a short follow-up later.
> 
> I can confirm that the unmodified patch works with 7.0.0-rc3 in my
> setup.
>

Thank you, Dr. Thomas, for testing this and confirming the fix works.

Can we add your "Tested-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>" ?

-- 
Henrique
SUSE Labs

