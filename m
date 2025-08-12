Return-Path: <stable+bounces-167110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254FB2208B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE47217D4FC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 08:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560072D9ECF;
	Tue, 12 Aug 2025 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UlnmWENr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312B2D6E41
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986611; cv=none; b=Llf8/UHRWOVHicMHTRvMEsea1ZI4a3F+sjCtMRwAj+o3w0VIHsKvkpvvtfKVErh91cgbYe8TGgSc2KMBCTr2cbQIYIsTcLFU5+bUveznOe2Tog5UVsqhUo30orllI9TDCOLCaExeWsQNqAa4uHFyP3GlQMCtId5JyFDsm6ZN6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986611; c=relaxed/simple;
	bh=TmG/FwX1Z+KG9oBR+e24qm5Da1wVp1/woMhTMqVzyj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPj6/Az0KoQ5LLOXyYW4me+up6vy2J7J4CVshNVjrBhVs3UEvy5CMlkrWp062ZedrwPjiScvgrkRz76xhclvUOH+XGsjGtZ47abPPUt9EYMspZnOVv2/PUSX0+C9APEZHnxFyl1ao2yQh6rMcboqNDgjfmqC1/JdRs1YdAtnsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UlnmWENr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bc5e68d96so4490937b3a.3
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754986609; x=1755591409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zxaMgybPgDD6v22fcJQXLMn3RlloLK4Y8Yb3NmfrbbE=;
        b=UlnmWENrpCKQv7x1nC85HIcpEf3MQv8TKdK366RA6BACOGCKcODgI9y5oohX6NpxEQ
         uWfCALfYhw8nLUSjU45iEw2eFSKmYTSc1oKF2BOEf8su68C3b/Y/eYAEP4kxTIaQWkrs
         xLFBpv90XDuJreLxowwntzMyZ8rm2YbVWmlcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986609; x=1755591409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxaMgybPgDD6v22fcJQXLMn3RlloLK4Y8Yb3NmfrbbE=;
        b=l/Rd8AwdSgDDWKin8JhnjI3CEi1MC9tqfuIuo3Tpn06UVDqhmsZ0pVdQlex2YqjR8P
         a8wG1SUSGFTC5QvEI4kCzW8wS3DDvYuC0g89ETyMZ4rwl+5PrtYVbmlRCR54HlphxJKw
         V26V+CI0F7V/XFXBEPYhpEI6T2dthQVRQqb1NeHL9YjRz5pvs31g9zpuWqx52Q46Uwye
         RBVLBKgf4xEovKvf46JJblQES+UP1BqhS0epvpsb0vKOr4WDKuK0kqKGZphzaF3zj8uj
         ZkzF8P82H6Ua011Jz++dragQzYM8h+bi+1fzltZfEKoi7lUsQOTHmAoU1347o6z2tnVf
         X4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUtPcl2pMnUZBuQD76c1r53TN0Z2LWCQwfGmrNqUvM2NgpTbKHrG5e+XOZiHZ61hDht0ArI9Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDnZo31AOlGD5E+kCbsUrJ6hqJgx3p0/hJQUwY1ug5n950D6S
	3scQs88xXgY/Hzs0KDOG+wuwSiqkghcaovxPVDVTsdGk61F8x/V3V4dFImOIUBukAQ==
X-Gm-Gg: ASbGncuT5Jmwab7gJrq1aGTojgmGJzN1/6I9J3MkJZSjwjgRaWWElTKwLBt4sOOpDwb
	djQNnrzV0JTyr59Nx+eOgRo2ICONYixi2xyU3/WhrjXMcGj+mDA8n7M5ZFGZGUzHOezzqD/7eh1
	fePwJQO5YTcQY9p73Y3FBYPbr1j0Xq2SugMc4sQYgkx6kOn+hZRHSPTT09h24mVYwmpWHLxZsTp
	pgkrkeB2Lf35XWQw2eIa5lleunoU+NIDg4cmnSeJACkECVnJA03BTC7DMHtB7MAvxB6CqH5sIyQ
	oku/uB+8jCCCEQoTmPAf2SUicnkuHnnQ73FCeTxeuUEu/YtwxeRjho6ca/l8XPvWRqD8AOGPJ/7
	NXaeHYXUpBNnwZHIIByx/pzCjpg==
X-Google-Smtp-Source: AGHT+IGAQhv+XQu7zxtMwZtfypWdBZFIiPAjShO1zW4mrAB6Qz7JfgAM5W/0dX5Dcc6D1acAhWdNHg==
X-Received: by 2002:a05:6a20:1595:b0:240:1c36:79a3 with SMTP id adf61e73a8af0-2409a9716d7mr4274592637.22.1754986608948;
        Tue, 12 Aug 2025 01:16:48 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e529:c59e:30f9:11d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b429920ab6dsm9824345a12.58.2025.08.12.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:16:48 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:16:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org, 
	Jani Nikula <jani.nikula@intel.com>, Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH 6.12 1/6] drm/i915/ddi: change intel_ddi_init_{dp,
 hdmi}_connector() return type
Message-ID: <bon34ediqv6nxzbd6yx5lnz2nzatmqz4z4sw4popx5kjjen4im@7ytbkzte63rm>
References: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
 <qtx56p35nqiuds6hvhi5d2rfl2hdh7xir7qjvoduw2n7hkyj34@4hq75a4bh23i>
 <4r4r7x4b63f6366ep5ijnve6ru5m5xv65puarv3kwrsv47t7er@xuk6hsipfe3u>
 <2025081221-authentic-swimsuit-ecde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081221-authentic-swimsuit-ecde@gregkh>

On (25/08/12 09:35), Greg KH wrote:
> On Tue, Aug 12, 2025 at 03:35:54PM +0900, Sergey Senozhatsky wrote:
> > On (25/08/05 11:11), Sergey Senozhatsky wrote:
> > > On (25/08/04 19:16), Sergey Senozhatsky wrote:
> > > > From: Jani Nikula <jani.nikula@intel.com>
> > > > 
> > > > [ Upstream commit e1980a977686d46dbf45687f7750f1c50d1d6cf8 ]
> > > > 
> > > > The caller doesn't actually need the returned struct intel_connector;
> > > > it's stored in the ->attached_connector of intel_dp and
> > > > intel_hdmi. Switch to returning an int with 0 for success and negative
> > > > errors codes to be able to indicate success even when we don't have a
> > > > connector.
> > > > 
> > > > Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> > > > Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > Link: https://patchwork.freedesktop.org/patch/msgid/8ef7fe838231919e85eaead640c51ad3e4550d27.1735568047.git.jani.nikula@intel.com
> > > > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> > > 
> > > Just for the record, this series fixes multiple NULL-ptr derefs
> > > in i915 code, which are observed in the wild.
> > 
> > Gentle ping.
> > 
> 
> The merge window, and the weeks after that, are slammed for stable
> backport work.  Please give us a chance to catch up with the thousands
> of commits we have to now process...

Sure, sorry for the noise.

