Return-Path: <stable+bounces-241339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKY4J6R472n9BgEAu9opvQ
	(envelope-from <stable+bounces-241339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:54:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A1474BF6
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B84B330FD57D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0A3A9618;
	Mon, 27 Apr 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOyOQezT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57A36E468
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301293; cv=none; b=M2j5cUEHQCvVWVn9IHvCtwWQT2C3V9vcQc3NSLXCFPf1tRgfnQV48byHV3lI7UsMJKcexKj/NzErruzgTNLvZLheUq9Kol/nyOC0iBkVT+iQAhbjgxqwRd4IrCxcTXuTX7lP11zNhScaOrRv2i+lf7qPSyas0/xrQnDcgmyuI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301293; c=relaxed/simple;
	bh=4xdstEQtN9d2VydlCsWuNlInxa0I2W3Gw3auRkkxvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEGKkXyu7TuVdPDPTVjEoDA/xhTIbZOfTTXCGVF9bD0Yycb9DZdxs7FpLH1M5yoZJvClfdxcHw5bugWjAYwtwFkDjbzYxDNnQE9bhFljMP+RdWLd2zdhDspN4bHRYLYh1SIKTXBaVafDSa2Ug2ismn9pGtvTuhr5mC0Pe4g8Cp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOyOQezT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfd832155so7708977f8f.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777301291; x=1777906091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTcA7y4hzbQFYWxx1WwEVcRWIQQQtI3KW/oxlJQFs7Y=;
        b=LOyOQezTnEpSTus6l3eJPZhGgW+9t9tiVJjAATWKRwcRi6wgXq/YQL4T6DZ//AhAZh
         RuB0ZxEoEYfeqrJskRzOCmqI1bwm4x+MYCsCt5A7YRd8oowpDuH6D3AYfGxhtlH41GLw
         tv4WR5+6caFO6mCiHF6uOnLPXWmbSZYt2QIdPn5EqOyPYLV5is8SDageHhm5DrAjkBFy
         JdBMa0sVS+TPfDlAQKRcf14pqljDps+EN7QSJ/gAh/68O0eDqiYtocHeEyD7gsuGZqn0
         UiTwW/vD6g+oLUYJbXJqNBJ87uj2PvZBLyGK4s389+s93o2FrcZ6wzQwJ0dqdFHs+SuT
         lQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777301291; x=1777906091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTcA7y4hzbQFYWxx1WwEVcRWIQQQtI3KW/oxlJQFs7Y=;
        b=KNzYZPRLNFLDp91tIM0v2gC2riIXxd5CDysxlNuR4eofUvhEkq0tJS62ieFEzQHoec
         OZDdqXGwaKz779ix3zDBy1TDudAGgzT57YFayOWqibxFKj14fkw9WnSJ7e2krF4Goukj
         wmbqsFEiJz4ziTSGhinMyU7Ee+p9bBQCnzSwaRsexY4tXC43zDV0LZmIkiRRx7CcEEgj
         mlq88l4rMCA2Gg0jKCkLECDN9alHj09ZaKLtZ/aOi3Zp8lyBozHqqb3ohgiCu+CmYhun
         qXWbpAM3jC15N2Zqi3EOsiiXuTg1o2Ad6oW48yRj2++/kBD3kOeue4kf/iHbWN3/ysa+
         H9Uw==
X-Forwarded-Encrypted: i=1; AFNElJ+uyQeRWsqf6cz2QLYF73Vlc4CbQemA4TZXeXIzrVNSseu4baNXipwxZLz7IfoEIDcqiI924JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFPnT95uVEFbXeEk8N4otcw2hy5kJ8xdmdaMqSij83XSZnMYgh
	aVEeXw4Oecf9QD2g1ZURpI++juTZIF0ar6w0ZxtVRq6fY53AqbGn3xCx
X-Gm-Gg: AeBDietYdNkZehw9kJiOU3hlR8anQbrWNqFRW76GEktE+zuLaQRduJXdJ60EoGDAi0q
	dhcvrtVU9GhDLXgYa+z2hlvPLIbTrpjezRrdPAyIG/UrOINKsrhhA1/uYcLtLkp6cqYml4CKfMB
	ee/D556XZ4oAAdcM+FSmhYtqPfJxjPcYH+vbioHj0vb+vBB1D9MDNKLeRq524hlS+Xcl7hEpYsv
	bcK6OI3vwJZ6G3zlCgeSnG930sLkyFyKBOf42Oi8rC83QExa8xMSWq47rSRYzVOwlMHznN0kIlR
	jhp94qJ1hRw2aPHGG5tksfiQr9SbDdrIsJRoihPiBNoy/6jvzUyUljQAsK6j71vclajUpdndeRA
	pzKyRnt2+PoI/aEvwpiVIRes6L11zywZ2bguoYcTCQF/s+7UrBRhYYfxMvj3jA89jeVZlud4uef
	bJkEaqkc1SYbjxWCkQsUsYOA0uaIQDIA==
X-Received: by 2002:a05:6000:1447:b0:43d:a37f:8d5e with SMTP id ffacd0b85a97d-43fe3dc595bmr60078822f8f.18.1777301290496;
        Mon, 27 Apr 2026 07:48:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e44f69sm85182307f8f.25.2026.04.27.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:48:09 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:48:06 +0300
From: Dan Carpenter <error27@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8723bs: fix OOB write in
 HT_caps_handler()
Message-ID: <ae93Jke4n9nH2kCg@stanley.mountain>
References: <20260427081748.3407939-1-hossu.alexandru@gmail.com>
 <20260427081748.3407939-2-hossu.alexandru@gmail.com>
 <ae8pq5YzEe2wTJmx@stanley.mountain>
 <69ef2c47.5d0a0220.2e33d8.bde8@mx.google.com>
 <ae8w9tkpM8G2NWWM@stanley.mountain>
 <2026042737-riding-bunkhouse-f8e0@gregkh>
 <ae9db6KjYMsFOG3F@stanley.mountain>
 <2026042713-buffing-recite-c3d7@gregkh>
 <ae92d2MQXf4MZcPg@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae92d2MQXf4MZcPg@stanley.mountain>
X-Rspamd-Queue-Id: 0D4A1474BF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241339-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]

On Mon, Apr 27, 2026 at 05:45:11PM +0300, Dan Carpenter wrote:
> On Mon, Apr 27, 2026 at 07:11:28AM -0600, Greg KH wrote:
> > On Mon, Apr 27, 2026 at 03:58:23PM +0300, Dan Carpenter wrote:
> > > On Mon, Apr 27, 2026 at 05:11:19AM -0600, Greg KH wrote:
> > > > On Mon, Apr 27, 2026 at 12:48:38PM +0300, Dan Carpenter wrote:
> > > > > On Mon, Apr 27, 2026 at 02:28:39AM -0700, Alexandru Hossu wrote:
> > > > > > On Mon, Apr 27, 2026 at 11:17 AM, Dan Carpenter wrote:
> > > > > > > We need a little change log here.  I was hoping you would provide
> > > > > > > a link to the AI review in the changelog.
> > > > > > 
> > > > > > Hi Dan,
> > > > > > 
> > > > > > Sorry about the missing changelog, will add it in v3.
> > > > > > 
> > > > > > For the AI review link, I don't have a direct link to the bot output.
> > > > > > What I know is from Greg's reply in the v1 thread on lore.kernel.org,
> > > > > 
> > > > > What about a link to the email on lore?
> > > > 
> > > > Sorry, I was on a plane with no connectivity to look it up, here's the
> > > > AI review for my patch:
> > > > 	https://sashiko.dev/#/patchset/2026041408-grill-mahogany-d1e3%40gregkh
> > > > 
> > > 
> > > Ah.  Very good.  That's fair enough then.  The AI is very convincing.
> > 
> > Yes, but is it correct?  That's the problem with these tools :)
> 
> If we go with this approach then probably we should probably
> change HT_info_handler() to match as well?

No, sorry, I think HT_info_handler() is fine.  I don't love that it
doesn't return error codes, but since we set pmlmeinfo->HT_info_enable
on success that kind of works as error handling.

regards,
dan carpenter


