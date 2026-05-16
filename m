Return-Path: <stable+bounces-248992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFhcIRhJCGr3hwMAu9opvQ
	(envelope-from <stable+bounces-248992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:38:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1062355B2EE
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96FEC3013D70
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34813D4135;
	Sat, 16 May 2026 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8C6ztt/"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F83D0C03
	for <stable@vger.kernel.org>; Sat, 16 May 2026 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778927875; cv=pass; b=bsEcRc0TvxNNzKOijNGKXfjBSN7eul0Yp6aehz//6lv5AKIlAO0wPzTNH/UuVwEdm35ATs16DYNHdqH/+6TGsQOWUtGUoEoIqKcjjV4q/cEgFAqwUfKxRqjUkcSv9NrqwAoNSVQMSUWB6oPOgCXm+UVojS/QXpOZEDNLv2GZriY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778927875; c=relaxed/simple;
	bh=wYQd7VYE6weklq/tDHo+4Eg5a0/6gRBYCIL7sd5HERQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7WaCsmd3BNAYfzgpiNnlvsuzDoRgcz4cPx9tWn7tMnYBLTthgdOHaOav1qINO9SUBMANfakD9W0Hk8YO3Bx0AhgOeTYlKTezCUAtioTStDh/elLlADNw05T7W7m4ydx9sYUCHmvn8eGIirTNl90cTabGOzZqKBa5aeFGn+hokw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8C6ztt/; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479d37e7d7fso224208b6e.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 03:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778927873; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+q5F3LtGqFr3jAclXi5YLMvZ5uahO7PYrb5XwFJPalJ0MwlQo2gALZdMX+MwHXtOx
         OQQHPgAiNKmjaqSYnDTfDRmm9iz3sMmsu3HW8Q6aGPddXm6xkUNu4LJUGmwlFSaPQJ1E
         1fA53+d3fE7NlCzFTceXJJNuVCf7g5TyUl+BKRW1UMxS+zoAy+GubAW3zW7r7jfnZBGt
         npo90axrw9NBqnBYdHZZEgvk1Plg185MOnoSJ5gBTxNo1FV7COqyDgTT8Ox7HffTa13E
         5GadesQKXgk70PA+mBKjNq1SnsboJQ1BDa8RGACYNlEWzSnR3aGX/Z0w8FKOXdRXA0JZ
         SIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nLgGU3hI1hvXoPjrbJDKzwx/g0/uUa7uAL8mWcmhusU=;
        fh=+siE1AVnwAR/htv2Gpd4JAQs6Pc+N/Y5tt1/8LSdCes=;
        b=SrihYHl3yb9J2VlLVGBkpN4yH9BlOE4x4boO21Teez2gykxcdRYUYcHcQtG4+7F5RJ
         DZni2NodBNmDJbMkWUjg21WaVzPOVz+b5FaSwraWQ6jEiiPT5AMmrJZGDODjFSZJx3DS
         9mdKq0CnJQWC1AAFo6ceAAaqjuj7vkew+1NbV3j6SfuiJwpX0cfhm8YbBDuO6Crp3lE7
         9BblY3jr/gPGGBN1qlM78ky7bUt/J7S9uuVo/MqtxLnPUTofo/b0//arafPl8ZdltxO1
         W76+VAvjOyIqgpm3HebWDFxiCvhl7fyTvaP60P0MsXX8Y6CK+LUKSaWgr1nCs6/NYqcR
         imjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778927873; x=1779532673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nLgGU3hI1hvXoPjrbJDKzwx/g0/uUa7uAL8mWcmhusU=;
        b=o8C6ztt/F68I2NMxkn5MLQ9uCtLbfcxPtuSu1hJc/x0EBSWcDI/V6VrObLxvsveWZv
         9NkjhWTQyqFlYCVN0BWetvaIb/4QomIxTJ8/mJrkK0Oi8G/V+Xutk8DwpWAQ1y8n96Lf
         ArtNRlaVIJlukCP/QZ2a26ym+YwzCv8pN3WjA6/gY1ZbfF4E7Pl7HkLNHPM+SUXkKnnw
         paTMb8drONsNgo+eoqU4endHcey0WyIZg3C07dVIH71xPOrHu3hY8K22reZTOhhpZpf1
         XkPtVMb6lfg/ynZzNkqSxuAUpL5XZj2TJybi3VLY+uKagDZzE6M+xIH51YqZ8U5E720H
         6Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778927873; x=1779532673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLgGU3hI1hvXoPjrbJDKzwx/g0/uUa7uAL8mWcmhusU=;
        b=cf1my/xPRqkbHvoOfJe3P2yCw+4XqltgouAGNy/xFrR4stqvBS08h/eGPamy8dwldd
         oOtmsZR+B1fDIZwjhEXgsfGKdTDvxgUH2V+rxNHN1qW20Un6ECrb1mqfDWNIxvP00kp7
         WltsjPY1r/BZInXrcVjyOF9+ELpmrLogK6IVWIfd14E4/bNxBw50j1hsNEKwHdjjBDuU
         cQBn5AXFPKc3uH92D3itiIAcYSx0TJV/5v/Ww+Mrq3rLeCfVJ8ZiXII4+ZeMmud30fxs
         F+3ugtGBh65uS+Npb5eTLsk0kPdYxUOkrevyvnzU0q7m4sV+veBQIp3U2wDr+s+yTFxO
         i3Ag==
X-Forwarded-Encrypted: i=1; AFNElJ9BVEW2kjWChjneO2kSPf+5GMNmGJnyefLAYHQCIziiwBW0nesrhCJbmJEqN4hVc4j0pih0XYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4cEu+bknboUtFC5KVIM7ueMIu1BJfq4ZSSu3XqX4ZZ4ThvJ07
	HA6EVxmLpV/7dNe70ZIH5ljdm5VK2fuPLZA6AkqNTNSAiDIUzwxGPbWRewozZH1UFr6lTPrwOn/
	ZJvrNpfzIyjimpC3DLs+ywF2r7Kabssw=
X-Gm-Gg: Acq92OEeCFbJwaBTMRcnDST9zdw8oiqVt/TOUgi4yxPslnhBG7HmCZSg9lWckUHTXBu
	jJYIIpx0adQ8lnzhUGqu9ysx2xXn9Bt/oChj8MXArLOn4PDl1wxklGp6L7Mss7eszyMsWDLgJwR
	aeJXuh/5yXz6L9vcxFiDFE0D4Qg8oqSSh6g2iq0C2QecwyvjfolnveSbsX9jZdDwk4rmTj8pDUC
	t3TtMQrhloayi9d49EIY9rsJDfR+E+lqLbdfxm7tX6NH++gZqJGs6Zlq76Uuann6BE9fJeiYLTO
	NczaFckCvJVhL6GnGtizlTGkMgtAhP7G0snSQd5/o9uC1xv6
X-Received: by 2002:a05:6808:3992:b0:46e:df55:23fa with SMTP id
 5614622812f47-482e562d225mr4937835b6e.17.1778927873270; Sat, 16 May 2026
 03:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505173455.181358-1-devnexen@gmail.com> <afsGZOxaJFvgLKgw@ashevche-desk.local>
 <20260516112506.34bf411e@jic23-huawei>
In-Reply-To: <20260516112506.34bf411e@jic23-huawei>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 16 May 2026 11:37:40 +0100
X-Gm-Features: AVHnY4IlwekU8noSa01RMedGARv0RgMx3pQkmr3KjKH-eI-DwHl2VJ4jC35ZUTY
Message-ID: <CA+XhMqwSz-PPVBhZx4ubVdr1oJxbib7EY_eOX_CCFiV0SNLy7A@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: zero-init bmp580 trigger handler buffer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1062355B2EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-248992-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

Hi Jonathan,

sorry those messages had been buried among others, I just missed them,
apologies for the slow reply.

On Sat, 16 May 2026 at 11:25, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 6 May 2026 12:14:12 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Tue, May 05, 2026 at 06:34:55PM +0100, David Carlier wrote:
> > > bmp580_trigger_handler() builds an on-stack scan buffer containing
> > > two __le32 fields and an aligned_s64 timestamp, and pushes it to
> > > userspace via iio_push_to_buffers_with_ts(). However, only the low
> > > 3 bytes of each __le32 field are populated by the device data:
> > >
> > >     memcpy(&buffer.comp_press, &data->buf[3], 3);
> > >     memcpy(&buffer.comp_temp,  &data->buf[0], 3);
> > >
> > > The high byte of each field is left uninitialised on the stack.
> > > The bmp580 channels declare storagebits = 32, so the IIO core
> > > transports all four bytes per sample to userspace as part of the
> > > scan element, leaking two bytes of kernel stack per scan.
> > >
> > > Zero-initialise the buffer before populating it, mirroring the fix
> > > applied to bme280_trigger_handler() in commit 018f50909e66 ("iio:
> > > bmp280: zero-init buffer").
> >
> > Same Q, is any part of the above, including the initial report/analysis
> > AI assisted? If so, you have to mentioned this in the respective
> > Reported-by:/Closes:/et cetera tags.
>
> David, these questions are outstanding if you have time to look at them.
> I might be ok adding tags.
>
> Rather than risk losing the fix I've applied it with the tweak
> as Andy suggests below.
>
> Thanks,
>
> Jonathan
>
> >
> > ...
> >
> > >     } buffer;
> >
> >       } buffer = { };
> >
> > will suffice.
> >
> > >     int ret;
> > >
> > > +   memset(&buffer, 0, sizeof(buffer));
> >
>


To answer Andy's question: yes, the bug was found during an
  AI-assisted audit of IIO trigger-handler scan buffers (Claude,
  Anthropic). The tool flagged the partial 3-byte memcpy into a
  32-bit storagebits scan element; I confirmed the leak by reading
  the surrounding code (storagebits/realbits in the channel spec
  and the iio_push_to_buffers_with_ts() path) and by checking the
  prior fix 018f50909e66 ("iio: bmp280: zero-init buffer") that
  addresses the analogous bme280 case. I have not exercised the
  bmp580 path on hardware.

  I'm happy with whatever tag form you prefer. A note in the
  changelog along the lines of:

    Reported-by: Claude 4.6 at the time I believe

  or simply a sentence in the commit body stating the analysis was
  AI-assisted, would both be fine by me.

  Thanks,
  David

