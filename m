Return-Path: <stable+bounces-215570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BI2JqBYimnOJgAAu9opvQ
	(envelope-from <stable+bounces-215570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 22:58:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAF9114F36
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 22:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F2F301C5A5
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CF230FC06;
	Mon,  9 Feb 2026 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6V4iDXs"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676FB30E856
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674332; cv=pass; b=PakFGYdOBcGmPXp+PRutxl4PIvh1na5cg30iadJ+QnG0bEf0ykCvLP65gY37JVXtph9d/3s+1Xho0Rqpx/WG4a3jCFWiYD6wkbMpTz19yMRnM60eMhtuwPHxcxZPKBwXarZ0Hd6UwophL3du6GaHCjqn6H0uYT3wuviOI+j3WBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674332; c=relaxed/simple;
	bh=GPYUCSOAu7i52K1ewBTraLyuOA9MZ6Hs6QSKzwuBAcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nR7nsyHcNfx7YdM0kz+Q8/IhzGyb1JdqkrZmYffjeo5O09yHUocCj4ZtVuzPfZqTal+tLfBFToIQMc8Hjgl9E07vGevecWvfX/xF8AEDCfCEdmxIjERZiS/3qHwaTHLR/VI0KhYCq3arO5qpXdcGSWfgwW4NWthCU5kqNIzZlt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6V4iDXs; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-894674a4c4aso55773796d6.3
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 13:58:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770674330; cv=none;
        d=google.com; s=arc-20240605;
        b=j+F1bmmYXzJwjroA2Du6/NJJ6r3FtFqnnq8vHnj6fPIEXncpSra65t+fUaK2U+Zl5y
         Q+uCpxPX6aHg6AChvYE8pZD++z879/pUo+ByfMFaopYtJhZv8FdiQMiX+M22BulmPHq8
         6LInP5CQqXBYkPE8kx+DtQouzZZnkQuC+/+dFXlHYJ7ArWNOwMr9HuPhsokIOTM8T+Zn
         0s15v7oqpH6ibVBOI3a5QgjmbwTH8iKolEmMybTzUT/u8ejbdNTLLuf/lPiv1x0R2Mm/
         ErQBoDpfMqw0wjNH4BlJJiBC4+oqh+rrjlxDRYY01CAzFY36Te+uR0UyzkhTGLtR2g4J
         tHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GPYUCSOAu7i52K1ewBTraLyuOA9MZ6Hs6QSKzwuBAcI=;
        fh=BOyAR7yLyYKEBwkiwOqvhHk2DNh7ZDYqcvlefNcddkQ=;
        b=YKkbdQ5lecZemNRylvhprIrPyuNO3Nm8NeUrsK+ofTTBHxblbm5uKtNw4OB1H2rFsb
         jt3yYsOM3tjvXOizymy1m3AZvlTSQes7xgupjcmQSXcXrZuN2iP5Pcr+jJArdfxwGMLO
         GPH7NU7XSLbKtVE27FtupllmaSzs5JsmT+XnBaFYmowcxz8p7v2GRSUasuGqbFNgwQJS
         dJFW9HlptYY/yP6GXan1Y7O7X//b2AEMM6+1u7nlDLpjCo/W4R3eAYsfh7YtYvOEDsQB
         FDSw4EYDc2pf2SQVpCM6fgVA+2LUbqUkxqRJV/TbWbyYFOks+3e9Ui1Wg3NUx79kLsZh
         M6tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770674330; x=1771279130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPYUCSOAu7i52K1ewBTraLyuOA9MZ6Hs6QSKzwuBAcI=;
        b=g6V4iDXsZam03WDP8BQ01jUGJk2AdBi8il+C/636aX9CDdF5I5N5v+jeZQnMKSPtMI
         b/j160ZVNApawaOP/nL7Oy05RR4psQ2Cm7G471utVtyfe1UosFP/3xT9u3gR3P2mKryh
         Ln+BPPOMBE/OVDljqSAFulPZjpiS4Fl3T0RF6ce+MnHHdWXazjZ3jIWVhvX2/vRk4aLQ
         PHNQLEdpD4+i2JwdGAgK5+0X2F9kdD7jEApd9adkVzfpphV2MhGYPcjMtIK5k+Fu6530
         ZywtiKKkJMm4UF2oKBzODvEWTaTmUMGMHYUJ8f9KQIyoSVRfBmzBfppldwzkI7KR+V1+
         LW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770674330; x=1771279130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPYUCSOAu7i52K1ewBTraLyuOA9MZ6Hs6QSKzwuBAcI=;
        b=bonQKkY1/M7afidWW+O+ifjxaicBvCdUkdbQWaB0rdvdsvBC4QbPkIpv2FtuYlIyfB
         xLKdzRFABcYV8I7Rza2k460tO8ysonMpPVNsu7+x8VY7K0ZB72lOyYb1DnAiAT5Pi5CJ
         3JtmykPnQBdXaTqMhUbR8XUOuPqhSnJ0OsS40ya6rsqS/JIScTvOOY3D5bTmAdKVMa44
         i50r1lu8XA1aVi+Y7+L5vxI8j9oUKJfmCxb6IfWs677uMaUGt71l8YlnRSfg2Sf3CL3x
         hHFHLZXEtUj40he9/QwRn9ZNlCnS+vyqHXbicdQ8KH2KBEMab+M8533fgPbVd4eMipKp
         dBow==
X-Forwarded-Encrypted: i=1; AJvYcCWWFpCCPy9o3qmwqcT3hZ1+QR7TK1PaTvgt+wMqo/LYAv4/6wiHkFTj8rdgo3s0G4dNgKh6Hr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HcUiqxlucubjyr+03xX44OvFRLI1mS3GM3VGzq0nl0ClOEaW
	sxGMqnYsKFoTSSmeB4wRb5VbicY51oJZerqbyi717+IolhZ1RIw0Vhim5+R42kQW+SfLUebMoNV
	fu+QCiBN8MSGviiKaI3qmkXRio6/pkJY=
X-Gm-Gg: AZuq6aLFV352nBJn6KC4clCyJcGZChJBcFpQoX+WT87uvXTfrNrISWvBvL2qqI/spOI
	xPFUrh1ppmlFygM3+h1dGx500/AbvTs6ActoPkgae9vPGB+sH2d64MZfrrd/w+xTmLMPUW4FYub
	FLqSAOHQpWZwraCVKisgK3CPchwYC20xZusIH57J2hFWLRJuO5brfH2+AzjWZva0lB0n/1jBxz8
	X91pfT3URndwN4JXGNRirmCWWswz1JTV7rXmjGJYHSxLDHxX0ISgLEF2OGjq8+KDTq7paA7bJqK
	dGV2YcZk9+4BAYv+EU1YhcLn9xQZgOOoerP6xON/E0oNPmHmWH6/wpyf
X-Received: by 2002:a05:6214:21ec:b0:894:6ef5:9f06 with SMTP id
 6a1803df08f44-8953c82a798mr185381636d6.28.1770674330414; Mon, 09 Feb 2026
 13:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205065113.33547-1-enelsonmoore@gmail.com> <aYoAMrEVDNydXQdq@horms.kernel.org>
In-Reply-To: <aYoAMrEVDNydXQdq@horms.kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 9 Feb 2026 13:58:38 -0800
X-Gm-Features: AZwV_Qg03CbUZfZQjzZ0-zOyRKuF0TjPFhmb2Cnrm6DwBNFa_9HnPyaKTfrBqKo
Message-ID: <CADkSEUjdGka7vpZEKrF0a0R1S=S+bzjCpDRidF5d93_H7b2qtw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: arcnet: com20020-pci: fix support for
 2.5Mbit cards
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215570-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EAF9114F36
X-Rspamd-Action: no action

Hi, Simon,

On Mon, Feb 9, 2026 at 7:41=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
> I do wonder if this should be targeted at net rather than net-next.
Should I send a new version redone against net, or will this be taken
care of by a maintainer?

Ethan

