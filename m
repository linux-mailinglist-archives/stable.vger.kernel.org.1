Return-Path: <stable+bounces-241317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLjJHHld72npAgEAu9opvQ
	(envelope-from <stable+bounces-241317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:58:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB87472FD2
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F67830067B5
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A53BC68E;
	Mon, 27 Apr 2026 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBjvsCvM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55463BC680
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294711; cv=none; b=dB/Gd7Pb7V28BbBLQIy7Sevp6w/yY1lf+JfljaSjWp4XWoDG1wBLPfXEoK/HYQmpHfxqTBeDsIPzYduKhKW8mbnRqjZ3c/gRNL3b3ppF6bLtYSIQr5ptiHaN3ZsEzJcKZipKkQb7p0XhqnaaPxJoN1wc35oK5gPEalQnTofXUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294711; c=relaxed/simple;
	bh=R+JVAx+RBpQxJ2bs/jmXNm9xDvjTer0iDG0II/hdrik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZOFQRBVkNCwkcGxOsPFbjV/PeBQYzFr6fS8PTqS1Vk2RIUDGLhQpsf8klKD2aVhuKXjEOmc965X5RLQNIlgyJSS0bW/w3nin3fdhIXoCF9uz3LO9dYyPqVsggReP+fqJyVJonR5igWUjippTM90/WkXTYD7W+495foY9r2O66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBjvsCvM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso103545505e9.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777294708; x=1777899508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DWPwhcIVJegParEMP5xi2f1qREsVOBmVUf/CtH2XiQ8=;
        b=FBjvsCvM8Ije5JRcpgoF9DX2qi/gg4MmfL1WTRzS/tKVHqK/7hzJN1a0bNMZg1UC6v
         u1yK7aJU2gKu4tz6iKalFG/ESEQXd/iF+McHW7/o5Qjsw5Qc7ftiGzKT52D+x10ge0hT
         14mZsUAYk8ycD4GlF+olTIqE/ZS4JSEgO+EFNhQWvzb6S8pFaF8awCgnad/u+zMzoavS
         tKVbX6JCibq5YahFxfflqlEGGHDWfg598LDbwrGdS0kKJ7yfWuHHrlc/Qun5t5Sgq284
         5Aq1LWJElmpLEloIffhZRNGxA/hcpz3rd+SdGCK7GUsHuiyWpGO1GBimpqXZnFwB/RZQ
         8Fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294708; x=1777899508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWPwhcIVJegParEMP5xi2f1qREsVOBmVUf/CtH2XiQ8=;
        b=qLZ/UcSxGZnA/DyUbSzF2MNQTgm+4yjUQdkI9md1vUdoTHRS1DHnG6d3w0C8vQmHhc
         ib4cOjhA3Ux8kMsINjo803GP7qqnBUJXsRjhiPU+Is0XEhklNAgvorBl51dTUMXE2ZNP
         2xzv/rROhH3RDhalHiogf5MuLjh2RZPPv9Lq3C2+WTglTL9NChhXVFcNqpp6/6xCyO/T
         J8i/ODwLLTXB4fKUJV/nCvgtIBK+oaG9n+qz5Vx41VBz0q3pEZfxE+2pKUJf92Z1crJ6
         mzv85LAS36CKtq/HS23DuKBLPsRxNpr2wDwkeJJLnUX0/QI2cpuWpHYgSKLMgaRGXy22
         JKOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2HS0g+ZnD267N044DnjM7QZXTZ3QpzPfCM8zrd8ys5QMbGFA6e+wS4MoCwhy6HMMuSJNvjqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyWQN7wHsHqXSksooWMXsfKMj6v1i83ysETB9cealPoCsW5RA
	10EibMZjrFS+ju0JVzyQkhK/eOUEzGiUas4ffL8EPci1HDI72KPO0xRN
X-Gm-Gg: AeBDiespdbWzQf4siav+eeOpA1cTdUHB/NhTCpS0kokE5DSIkHX1FA05gHWXoWKc18B
	GR0JIA+POBUsmibg/yw1mE14p4MnxU0EK3jC97N3uMS2QnQag/5Yz1x3kl9E6fZmk3MYPhReXiq
	2yITjY6SEtoe3EPg7cpaxfCujQ/TWXEs12oP7Il6E0LEf0Rr5+xQAaShSvryHhJQ/LaahZDlnK+
	EDLt9pH8OfGit67ZVbcmItKSnWaaFv03ENWgJi8UjBRmvb6HBVoBR+MduBzQ07ASrqb14wDsFeW
	ochtdiw+SGEPvD+qrjMCGHf1NPnhYAI/YsIcCKGqxlTh4GgCcVi4olrkRtMXn7OzCcatB03pnoa
	8x5QgFVNwnlDoHZcDoES6i99WzLe/X8dHYAI+D3tT3XuvMhbTTMF/JuP9gqLScm8X2r3qYsvuZT
	rgP5iQvVHlhrbVstbDduu6wHdFtg9mkw==
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488fb8b91a7mr556712585e9.12.1777294708023;
        Mon, 27 Apr 2026 05:58:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm174070255e9.23.2026.04.27.05.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:58:27 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:58:23 +0300
From: Dan Carpenter <error27@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8723bs: fix OOB write in
 HT_caps_handler()
Message-ID: <ae9db6KjYMsFOG3F@stanley.mountain>
References: <20260427081748.3407939-1-hossu.alexandru@gmail.com>
 <20260427081748.3407939-2-hossu.alexandru@gmail.com>
 <ae8pq5YzEe2wTJmx@stanley.mountain>
 <69ef2c47.5d0a0220.2e33d8.bde8@mx.google.com>
 <ae8w9tkpM8G2NWWM@stanley.mountain>
 <2026042737-riding-bunkhouse-f8e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042737-riding-bunkhouse-f8e0@gregkh>
X-Rspamd-Queue-Id: 0CB87472FD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241317-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 05:11:19AM -0600, Greg KH wrote:
> On Mon, Apr 27, 2026 at 12:48:38PM +0300, Dan Carpenter wrote:
> > On Mon, Apr 27, 2026 at 02:28:39AM -0700, Alexandru Hossu wrote:
> > > On Mon, Apr 27, 2026 at 11:17 AM, Dan Carpenter wrote:
> > > > We need a little change log here.  I was hoping you would provide
> > > > a link to the AI review in the changelog.
> > > 
> > > Hi Dan,
> > > 
> > > Sorry about the missing changelog, will add it in v3.
> > > 
> > > For the AI review link, I don't have a direct link to the bot output.
> > > What I know is from Greg's reply in the v1 thread on lore.kernel.org,
> > 
> > What about a link to the email on lore?
> 
> Sorry, I was on a plane with no connectivity to look it up, here's the
> AI review for my patch:
> 	https://sashiko.dev/#/patchset/2026041408-grill-mahogany-d1e3%40gregkh
> 

Ah.  Very good.  That's fair enough then.  The AI is very convincing.

regards,
dan carpenter


