Return-Path: <stable+bounces-242516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF0MKIkI9WmIHgIAu9opvQ
	(envelope-from <stable+bounces-242516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:09:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EDD4AF6DA
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C7783007C98
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 20:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162C42317D;
	Fri,  1 May 2026 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnDC7fr4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C7423151
	for <stable@vger.kernel.org>; Fri,  1 May 2026 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666172; cv=none; b=tXXDos5bPBVZra4yFQDQsn009Y6xTGz3Mndp8FFs2sBsTIa4+JitHqWyFyQWAF0Jg0/Ic9OhyrlubXlI8/Y1M6s8G8ta6d32wSXwp+qQdXstDJwDlpCOMm2CUEvEp3bZpmgRri6KJTHXotdRObb7HlW4M60DYXHt67DSA45stN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666172; c=relaxed/simple;
	bh=8urvMXkl24OSZEB0wpWz9ry6TWKjiahjJExaXhP1+c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9R3dyxVgSvPtWFDEFc8BEFUosJDvlR9e+isTSkxZp6n2+/DnxqrVX5Bg+1Nd78qCUabW79QQ88YOpVplhuZu2udvaGBNFGANLK3n96gOc+leH6z++OlEIRatdL3vNxoeEBFtL/iVn4jNsfajtOCqWkiQWPhQz7bw+T6Y7zV5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnDC7fr4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-364f65f6eaeso848394a91.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777666169; x=1778270969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9efDW0M+5+xCAVk/QjLEYc7GQc94XnH8yiFV36Yucj0=;
        b=GnDC7fr4mCgs3WLus0hMXkXLcgMjItLxAOBAxo8KSQhgZ7n1aHBDiShJPfzyXe4GeH
         imv/FQi/U1In7yp9WDCQNP89HRi4XJX27q+bwjiMHKewHgYZNEmWWnmcFVicwmFsKZ8I
         iCbfuNToL9tQB/Rbvftwn9W0OgTgHMX/mjwhJQ2LHzMBRDCJF5iRDqbinKCFcFTDsrz4
         3F9x417kEV3NaSQEPx8TF1qePG0wxs6uoNwudx+P1IfOcjdZZ8YwiRgnw5wbM3lpltxA
         Zvn8lp/HFxlBpZNsxFjLpr2J3m1DMCq7p95J2l/1IJLHg8qD9T4ka4OgUtKp+RAOJxEy
         RT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777666169; x=1778270969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9efDW0M+5+xCAVk/QjLEYc7GQc94XnH8yiFV36Yucj0=;
        b=rNifCCr0TvTow6c8mJt5/sp1izfgBfCuOpCELZ7f3SnQASdV+huj++aFZDg7WmVmZr
         BSAt5twGfararRlV4S8c6P/rFdXLa2cBPFrKdA3/EkOjHosqAdQ8Uh8+xRfD6iovN5VB
         x/JDo6lDWQ9O1+b16+rx4uL86sK7heiO8kqgBYWTZxCYeU9zpe6T9MgbpDrXk6KpSMN/
         3I/SUiRg0fRUNIh7mET06H/lrPwDNKbCuQBkkqmznxXyrE+bS7o6lLNFEOlLjXW6Mnr9
         MFvtDO9wFK3IjlAX0K/jX/D0HGKsI713uiTDXihD7xfbduvSWTb042dL1dgdA8hAJobh
         jb1g==
X-Forwarded-Encrypted: i=1; AFNElJ/zzdPQc6RL8tdPHo6FOIzR1cbe8LeMWwmaJB9Qb2k3aM8OTKHyUX9EDskymgRJIBvG6Q0J9D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrkqhDtTjhcTIL2UZA/iJ0h4WvhlqEiiXAVhrUPVfxYOqpnXF
	qQMQdv47Lq/R8ZewvNyXgyK//JohLhD8b4OBBXSC+gNSzX64aTjnlo1e
X-Gm-Gg: AeBDieueIHZYO6oJUm6uQXq8x0w+D7wMQIGdCTxUgpu7wW9m13QYSbS3lsuFkeJ42dA
	b61KmZh6ZXPhit2Ng7v8MWZqR+gMtqbQ6fcItFXKkgGNtkTl+28oOxUO48LkLToaCAS+1R+xxy7
	ByeVeVnJKpDiJ5wu33LPnzQsVwxqrIw18UozPqr/BPGTYSWZHgLjiJwKzWbKD9a82SCHebUqdKL
	itQ7gi/epq5dOXprmX2gjRnTADlQ02AErytm7nCZoFUQB6OTPoAI52Xww1BX62bgOKT55/Ao0rP
	kA9Z6DTe0fGoHLJzRjP7CCv5lftW9UhRjPOVxggnZ4UhyDUVC8b+ET2+L8afhnZLBt0/pknvNx6
	Cn6L9uRjRP1rPpk5+yPZEGu+qnfWBIXQF5dZh7aPQ8owv48LFjwHBf2mwwOpmlHSdXBmfPje0uH
	Q44UxPQ2gVgDgMGgFj4T86K01hs1ZMDE1j/FHWIXviVkhHL6qlPsegBxOkWyG1e7wjX1f7h6XB
X-Received: by 2002:a17:90a:d444:b0:364:74c1:53b7 with SMTP id 98e67ed59e1d1-3650cda5d5dmr628144a91.2.1777666168755;
        Fri, 01 May 2026 13:09:28 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2ac19sm8253866a91.3.2026.05.01.13.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:09:28 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: stefan@datenfreihafen.org,
	alex.aring@gmail.com
Cc: miquel.raynal@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
Date: Sat,  2 May 2026 01:38:03 +0530
Message-Id: <20260501200803.3371428-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260421073259.12345-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260421073259.12345-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01EDD4AF6DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242516-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[datenfreihafen.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cambiumnetworks.com:mid]

Hi Stefan, Alex,

Friendly ping on the patch below.  It still applies cleanly to net/master
as of today (verified against torvalds/master), and Miquèl provided
Reviewed-by on Apr 21.

If you would prefer this split into two patches per Markus's suggestion
(one for the leak fix with Fixes:/Cc: stable, one for the misleading
error-string cleanup), please let me know and I will resend as a v2
series.

Thanks,
Shitalkumar

