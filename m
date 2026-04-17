Return-Path: <stable+bounces-238405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMN/BArH4WllyAAAu9opvQ
	(envelope-from <stable+bounces-238405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:37:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0374417212
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D31963108C4E
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43334CFD1;
	Fri, 17 Apr 2026 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8oaUG6R"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69A1E531
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776404121; cv=none; b=BDwl2Robvt+qsHWqCEX0t71qNZQZWqvTFh+i89M3O8ZF/g+O02LkP4r7Ushlx8c6H+sCzuwitFo/RXHVFom7coI/IozVnGZd/D7G1Sp56p+OX09jVWeaAFcNXdEJ1oFq7MVlBs9zz5STJgadQnu7uJinCWw3umXuRMOoR3ClLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776404121; c=relaxed/simple;
	bh=EJcM6oKOfwfxPw2Nk0l0PfRPbynwOQzk5Wfa2xYZVVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5isVaRnSW+TKnr8i0gIjRno7VdaAcpXgqBIqRNivGA4VArlev8TcbIU6IvkMoTp4dAZR8OkEUyZ6kP+a6Qqn78WjxNI8jBXbXz1gX1GX1twHaCV2qRuKCyAq6dtJR1DqiCjZ9hnR/7r1X78T2/X/EHZcjClbd+dX7I8NE2hhb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8oaUG6R; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d77f60944so171863f8f.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 22:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776404118; x=1777008918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4wWs/XssYPugQUAlHCPxJLSVS1ytnbWTpEWbUPexeQ=;
        b=H8oaUG6RgBLqn0RVEfQbMp7h4GOVRksvepC8v3PmFRXVRFgZT3WhhngmzImBSQRzqr
         2IiTSdj80UboI/PeiTSnbFdqmhfuYdmNpY6JwnGnDAlu7T3vkw320dr807bzAu2bfVQE
         A3O9TgotfWGwozeo/p+tnOxitGlWr0YMuMzbKy3jyjAT1XjZpFM99VaU0Us+bhuS4LLX
         Y2SFH5beELP/S6EC80QwAr6YKwThUN0CCTDO2CTWq512AQhBcEPAK48cp5ffNEmOf+Yp
         Xen5RYucxo0QIr07aJctD4/IhrCXql80uTxDfYptOowZVEHt/fvNom3OGICz5ZCdAesX
         6vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776404118; x=1777008918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4wWs/XssYPugQUAlHCPxJLSVS1ytnbWTpEWbUPexeQ=;
        b=hq6p2laxui0sCSfmL6gTjinQZnrxG0RUHRfIyfLO8w3yBRP0aiRamS0zhkUSEPbu8w
         d6SYajkjh5OWb7KiigAp4hzSPGgymz2/yT71bf2WpfgIfnhf/4wPQEOxXBk1actriyMh
         hgVvZZENPXNIhKoVUtujpCsvPD/dYhU99xxed+L6yC/z4dDIuDuY5FLNO9S88NFV2yT3
         1LkLXbdaPnkTq4cmjiY4W9QnInKTGYZxCX+bARSm3Dmojkz919xiodEdvJAWfjWRK3rk
         0bz7QRyYuh/X4wr+XabmYWXE/tJY+WZ0+uZub8VwJNobZkPLyVb+hInyY7ouZmlg8lAs
         NRXw==
X-Forwarded-Encrypted: i=1; AFNElJ9kwum8GEjMlxg91ehuVyCtHvFBWrnpFu919rK4NFDz1jsJRzvu1ZPafZSD9Dr+ZsQPz3yuQ5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2zEe2t2+c2EwVTXIFpgE9Xw4dZ7pyOgQFDIDZR2FCWDN+ezx
	G+JyuA+YGuramsiCruXHMO3l83s7/2tZG6PMVrdlvQ8XxsaA46N+1TPC
X-Gm-Gg: AeBDievkQDX+NXtex5eoN+qWod8u7jMh8qJi61fNs6r6epJUQ0kot9xQK+zOEjWxeRz
	muRnOjMIlg0roGmFjjJvCcUm8ZjnL+0J4bCmr9tgKynVdnW3WwO8F8tV7CCNmvyX5rzHk5PU0D1
	Xy5EOzMd7PR3d5E3GHe8S+Q4WwCwtRi2XjC4UIkNHn9L91nswn2DvvKy/aZyp5PvC/gwZ5BNlxj
	MqavP320l/SKgVN5w2OhDfL1vugeWgnm60E6nfIpVcJl2zssUWh+g/nG8MlVpOOAnv7LwTu9bho
	6yVEPkm3hahpScMadaKfLPENea1+OhG+BI9uQBcO5IQD9bzDIlY9VX8ReC+JdkwhmiTRonk4yFs
	rqIO+2PMBJoeY71aZPBPbBYtD+biCs8OlScQxClJXKfbR+lklscElVh3iJJGedQ3YiOhwgC7Nu7
	k1y5oRVpmhrLxT1fe8VkmUoh3mR5fFpw==
X-Received: by 2002:a05:6000:1849:b0:43b:9416:1aeb with SMTP id ffacd0b85a97d-43fe3e25681mr1785013f8f.45.1776404118534;
        Thu, 16 Apr 2026 22:35:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm1722143f8f.37.2026.04.16.22.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 22:35:17 -0700 (PDT)
Date: Fri, 17 Apr 2026 08:35:15 +0300
From: Dan Carpenter <error27@gmail.com>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: gregkh@linuxfoundation.org, luka.gejak@linux.dev, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 0/5] staging: rtl8723bs: fix multiple security
 vulnerabilities
Message-ID: <aeHGkzJNJ37JVz0z@stanley.mountain>
References: <20260417030110.42991-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417030110.42991-1-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238405-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0374417212
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sorry, we're really strict on the "no unrelated changes" rule.  Otherwise
it looks good.  Thanks!

regards,
dan carpenter


