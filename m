Return-Path: <stable+bounces-241337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEhOEQF472mZBgEAu9opvQ
	(envelope-from <stable+bounces-241337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:51:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A67474B4D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2185D3062C33
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AED3B6BF1;
	Mon, 27 Apr 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwH/Vh1O"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4B3B52EB
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301118; cv=none; b=Pxj1HdhFOi9njnyyAIqz2mpsXn+xLtvbHf3f52okKKV/2Q1o9IqXWNbN1KmHt3jhUTB3qypYrVKZX8YS1X+Qwv5jCO8TLxayNOhFWO/sOO+o5hQMvkvop4PEsyTj6eClnXI51iAF1/sIs5BOenZTYueYCA03yn7YxJtuLAxnzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301118; c=relaxed/simple;
	bh=d2FNAbFDRQWcUVWu7exSOqOsDpfZUHM7JIYdlmNtkjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WezuVAOSj/z+Wgc6M/6l+6UG+ObMiO4nCs+7A+3pKUvoUUoR1kAsbYFqoPHNmgZWDse6WGbfWHjehN9LoocSfvLKbnv1ua0VOAvYMnAbf72hPKtBvmicIyTkkoKCtpBTQB/sicd8bwOgNHsDxvsnK06mR35u37FK1VCOiiYxbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwH/Vh1O; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso95933715e9.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777301116; x=1777905916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBbooDkiMWydo0N/PYjSPsB4FcRhgQZ6/QelSimT4EA=;
        b=kwH/Vh1O6b0ows6zzMBVtNmoQC7lFLMKyBjiwOgRVoxjHwB3N80tWIcKVnZDhIdvWk
         cfADKKbTAKmX29fdvvZkNpKS/j9fOb1CeyZztEfOSbvoJnrint7+HMvPrx2el8O3hGhh
         dL/Ju4U9Ctm0TEN+hbqdh3AuBqZQrv+gDiqBAqs+uiEkopSsVqnz3uaQU0ln598sr7j0
         ZP1h3zW3cUwDEKmwUVCWL9tpwEUGKMZEJRJaTVMEimokUARORSvny6tFe98bfJG+msXT
         tBndLc/ZsolaehKLHEzmJW3HyZLiDtOkZVOMZvK5pvZnLkwTyp0+gWomqazRq4HIAutB
         knjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777301116; x=1777905916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBbooDkiMWydo0N/PYjSPsB4FcRhgQZ6/QelSimT4EA=;
        b=IT9wDW68sAkr2msaSJ1x/mQQtqeiP2du11nIzQ/4Qff1v1i0UHL38p0BuM+xGvHQW8
         QIj6jkHDsgRouFFeZxUcqQDj2J/kaQRWwJluUGHCIx7fQWncLc0t3Y52QteOuKce3hdV
         6XtPNqxC5XyiglT3C6LBSypZXETDbijBdlcE9XSaTxOqHGwo3x9OXzU3ptuDkJWIdmzx
         MgXhASQi6MPbs9IVZN/ttZCz/FlYto8g1J4MdVmm2rcIfWGeE2Q9enaX4v8tFrDdNTJ+
         JnET0kMnp7Ld+32Am6y+HIhgZlZuhl8TjjELC03lRtBxP8X9L/n1/e8ALUlpQk6sBk13
         VsKg==
X-Forwarded-Encrypted: i=1; AFNElJ/5M3D775udgo1Yq+qEsufoOTN91sM0xoJsBvEoGUuZoRhJy9LQYTGiz5xaLd0ZAslSQoXuy38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mLHi4WFzxnPsJZlOABivUNJR7Nk/InezMghSUqHlFed+6JDT
	pRkhzWTCnCs55c4Q/i+lpkzSioAD+wVwwQnxM4Vz6936VKNlhfDG+Kaa
X-Gm-Gg: AeBDieuW/xxzT3MMTZj1pAgujucNUN1XJWcGJyt+EQTARtFfmrSB8qj+sMRAK3rMLbD
	p9+I5CtSgw7CtGO2WAr7LOFNDe+Zr0CmiW8rr+XUJzgogMnthypLsWNKtNzATzzxmVwNmbr+ae4
	cohiedKnPJDPeL9tjuynxPqt8U0ek4izag/A+QE38F4pyryUdZK3y/mYGwVOCRt+Y5Tjm5AbS0D
	4IyajCRZKmEZRbJGk5w9ezW6PsCLq2WyHjyk5HTPXSrxzp8euTVU8ywVyYFzBgkpRWxOQBJRK0r
	BMQcVZP8+FcjkLn0M2O+LagpuK7Q8G0s4qz55g3MKQ89G8+qifxas+aSw8NyhvOD8JxXkzoyuYC
	zkyhjjofyo78EbDcq9HTzgUEwN+GrYMfAU8Y+KuykDSJ2huXUor7YxalCtDMTN792iJa8F+88H5
	vMIOjDffZ8JubOEsdSP5LEXnPKg0NK8g==
X-Received: by 2002:a05:600c:a106:b0:48a:58ae:9933 with SMTP id 5b1f17b1804b1-48a58ae9fbdmr256070565e9.18.1777301115717;
        Mon, 27 Apr 2026 07:45:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cca5743sm575074515e9.9.2026.04.27.07.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:45:15 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:45:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8723bs: fix OOB write in
 HT_caps_handler()
Message-ID: <ae92d2MQXf4MZcPg@stanley.mountain>
References: <20260427081748.3407939-1-hossu.alexandru@gmail.com>
 <20260427081748.3407939-2-hossu.alexandru@gmail.com>
 <ae8pq5YzEe2wTJmx@stanley.mountain>
 <69ef2c47.5d0a0220.2e33d8.bde8@mx.google.com>
 <ae8w9tkpM8G2NWWM@stanley.mountain>
 <2026042737-riding-bunkhouse-f8e0@gregkh>
 <ae9db6KjYMsFOG3F@stanley.mountain>
 <2026042713-buffing-recite-c3d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042713-buffing-recite-c3d7@gregkh>
X-Rspamd-Queue-Id: 93A67474B4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241337-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,linux.dev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]

On Mon, Apr 27, 2026 at 07:11:28AM -0600, Greg KH wrote:
> On Mon, Apr 27, 2026 at 03:58:23PM +0300, Dan Carpenter wrote:
> > On Mon, Apr 27, 2026 at 05:11:19AM -0600, Greg KH wrote:
> > > On Mon, Apr 27, 2026 at 12:48:38PM +0300, Dan Carpenter wrote:
> > > > On Mon, Apr 27, 2026 at 02:28:39AM -0700, Alexandru Hossu wrote:
> > > > > On Mon, Apr 27, 2026 at 11:17 AM, Dan Carpenter wrote:
> > > > > > We need a little change log here.  I was hoping you would provide
> > > > > > a link to the AI review in the changelog.
> > > > > 
> > > > > Hi Dan,
> > > > > 
> > > > > Sorry about the missing changelog, will add it in v3.
> > > > > 
> > > > > For the AI review link, I don't have a direct link to the bot output.
> > > > > What I know is from Greg's reply in the v1 thread on lore.kernel.org,
> > > > 
> > > > What about a link to the email on lore?
> > > 
> > > Sorry, I was on a plane with no connectivity to look it up, here's the
> > > AI review for my patch:
> > > 	https://sashiko.dev/#/patchset/2026041408-grill-mahogany-d1e3%40gregkh
> > > 
> > 
> > Ah.  Very good.  That's fair enough then.  The AI is very convincing.
> 
> Yes, but is it correct?  That's the problem with these tools :)

If we go with this approach then probably we should probably
change HT_info_handler() to match as well?

regards,
dan carpenter

