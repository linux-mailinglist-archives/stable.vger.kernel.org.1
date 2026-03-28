Return-Path: <stable+bounces-230755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAoqBJ4wx2lqUAUAu9opvQ
	(envelope-from <stable+bounces-230755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 02:36:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6266634CEC9
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 02:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7592304A6FC
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F8A332634;
	Sat, 28 Mar 2026 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="meYBzJDg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877E3382E8
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774661753; cv=none; b=ZFeHpisu2dC86lPrxzgkbe/iReW1JGB1M/xVIV1cedxUfl+m2mEGybMS/sXxa0vXiGTqo+ozgXJPLFwH4JVQ+ejJz4Bs99yuUjc2Ow08w9rUve4ylJUJwHCEh/Sfo/7ROwmq2WaOGDSAzF+fx6YHayIShREGCDhJ9trYTJNnTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774661753; c=relaxed/simple;
	bh=z2MmL3nP8mfs2Zlt0iAPU0Fg5DUKl/mAWaoCQ1T6W1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxjlHI1Ra8UON2T+5R6IxpnU7J8ITHwVWRPTqNGQbG4JtHP5jvr1tRASTZH4zAJpw0DBQsMb+A1BiXqhg/ta1GWtmH0c7tE+WnX5l2fhtDKJ0owpHJnc2u9TG3QCOhbTveBudtvzlerSAzJbcWsWd172Fxylf/UhqwP8/yFQdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=meYBzJDg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd7ecedf2cso291985585a.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 18:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1774661751; x=1775266551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5hK4EUCCI1OM5acjvsX5vMrWb1ZWj9bGqsM2AP+IJ0=;
        b=meYBzJDg3BbhqqYQ7xSxQfgA7dYbnFpV//HXwIVn3x6YoEoUqfVT54vQpOS4xz+Thn
         yoLzOD4o4KIRlYcUOrcvIC4Zl1Qar0qBIpkcl+OjWWc3uQYPagxSiYy0GsPq7rKXwdGO
         tMlVbZegvPQyc/PjhaJvgaJsebz+L8gHlB+/DYe0l5I3ltGo1u+pLLQn8NZ4hfJe5Huw
         VeRyf1kJyH8D4YCeX/uilDbd+6nM9vLh7M00HaGAbF1bnsHd8wZg2AuDBtuwLpx3HR2t
         XSdw4rmd8Tqmn+nhiEVib4tPZm09Fzre2xTOu9GmRqVXi9sXB5VFVs0bAs176tfrB47m
         q17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774661751; x=1775266551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5hK4EUCCI1OM5acjvsX5vMrWb1ZWj9bGqsM2AP+IJ0=;
        b=E1TP60/Ahj78n6aAuleLp545UtFFX/39scvuj4u4CGPzMkQItR8jHFcuUOg5tm4G1z
         VNycMUkWtyyarBWlzHzyxHjCy2DqD/8XJO0P42LZeKwI+L4EsO42LWSx+HXY+97gn15p
         Z8H/sc389hWAOHGFzRlEGWE6altPsyl/cC0DL6rsvwOHUMEEZOuVZy1U1BchfAt/bfby
         7UqXkHxaUANbwETpnemtNFrVFZFK6Hz9uQRLY0QJtI3PhHwT/C2YNfRDvAzluUJdUcDX
         w9Rmci+9UcoCg/OtisPxx1rMAYdi0FPJookJcEYKnMQpKhTuu3zLHdIpy815uv7jhYkV
         VWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhdu11elB9/29ZzqLSaeDjejnoBsEB6M5cQQUDz12Q/bbp1qNUJrRWgbotNQYhgqPMA8hkgnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAmVK/DLAx8KBXdTa2yZpJIBY9fXVEoFOnSTX9/Sn1VoXpQWl
	7cBno8l7MsC5+lFAdsyl8qwttVUn2Etfx1J44GtdxzpIBVzXRtMCS4M1RLSb+Q9bTe6h7TylvUv
	iPDG7sw==
X-Gm-Gg: ATEYQzzY/JZRPKy6mBQFdeJPh1zJmAfbwlTYiaZu7u/zvt9+m+pH2NElWxyKupAp87a
	vRWoWuoTywwUc30tt57+evathzgSAwOGqlVrMCjgZijdSK7mxe6q0DinTNcPeoJFk2vmyA/dQK8
	g3T1ddqg8ExMXObOTRHfsoooOmrBpObAPYet2N89ySuoCb/wP9uegxDPsUdB3VdxQZriDric+UL
	TJBOCJ3rrcqVGgTgawY6WeTjdTJ73rwBZXNW1UzkNpo1n/4IxSnAx+hXupOf4yJNOS2R0UJNB6W
	P8rb6G20/2lLI4+b9xWinR12MZUpMRiFEUOIe9hhcOghrukmlycgGpdEYTA6U6wa2hKq/5kF4I5
	QpY6LrWlT/I9rI8B4UgffzSca0jng4PaLpvBLV/1xfu7ePi00emmlIphYp2yy/FoNqEj+/jMeB3
	O8YI0cox6yqHzpNTEDRo5aUTc8pHQSf4AuxJU=
X-Received: by 2002:a05:620a:448b:b0:8cf:f215:24c6 with SMTP id af79cd13be357-8d01c648eb3mr589502785a.21.1774661750722;
        Fri, 27 Mar 2026 18:35:50 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::5a82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02803f2c9sm61518685a.23.2026.03.27.18.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 18:35:50 -0700 (PDT)
Date: Fri, 27 Mar 2026 21:35:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
Message-ID: <5ea67deb-e669-4faa-be47-b1b225f1194a@rowland.harvard.edu>
References: <2026032114-unlocked-unmoving-091b@gregkh>
 <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
 <6ff1444b-f83e-47f6-ab0d-6745738523ba@rowland.harvard.edu>
 <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
 <6511a5b9-ac67-49a1-8336-3d2afaaab593@rowland.harvard.edu>
 <CAD=FV=WBgKN2MNO-xBHZ3tRN91M82vk3h1AEAXtpBQ-nQocKCQ@mail.gmail.com>
 <bfd4e1f5-7bc5-448d-aa33-1a977bf00733@rowland.harvard.edu>
 <CAD=FV=WeeBoQAoPgNq+5ocZas+mOn1RuNto3k57ag4ODo2vOLw@mail.gmail.com>
 <852cd509-4ce1-4b22-ab1f-b9b9bbf6a52e@rowland.harvard.edu>
 <CAD=FV=UroO1vQYJDkrp86D475F8b-RStUXYejWwTQ0NqP1a_ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UroO1vQYJDkrp86D475F8b-RStUXYejWwTQ0NqP1a_ew@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230755-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6266634CEC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:30:47PM -0700, Doug Anderson wrote:
> > But why just in that one case?  That's what I don't understand.  If it's
> > not okay to bind at this time on the driver-load path, why is it okay to
> > bind on other pathways (such as bus.c:bind_store())?
> 
> Ah, I see!
> 
> Yeah, OK. I spent more time, and I think I've a patch that will
> address things. I still like adding the "ready_to_probe" flag and
> setting it in device_add() right before bus_probe_device(). ...but
> I've changed where I'm testing this flag. Now I've got the test in
> __driver_probe_device(), where I simply do:
> 
>   /*
>    * In device_add(), the "struct device" gets linked into the subsystem's
>    * list of devices and broadcast to userspace (via uevent) before we're
>    * quite ready to probe. Those open pathways to driver probe before
>    * we've finished enough of device_add() to reliably support probe.
>    * Detect this and tell other pathways to try again later. device_add()
>    * itself will also try to probe immediately after setting
>    * "ready_to_probe".
>    */
>   if (!dev->ready_to_probe)
>     return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready_to_probe");
> 
> I think that is more inline with your intuition that we should return
> some sort of "try again" code when we end up with this situation. This
> should also block _all_ probe paths safely by adding to the deferral
> list (just in case) or returning -EAGAIN (in the case of
> device_driver_attach()).
> 
> Does that sound like what you're looking for?

Yes, that's exactly what I was asking about.  Let's see the complete 
patch!

Alan Stern

