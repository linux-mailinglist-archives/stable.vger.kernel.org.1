Return-Path: <stable+bounces-56889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B449247C4
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58634B24099
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080771C0DF2;
	Tue,  2 Jul 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aex1PcL4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1A381CC
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946837; cv=none; b=UhafLMPdSR96kWFIg/B1W6z0qo7+CTpPppPscvUhnewr5iNkEhNR7iCAbwsyXoZMShEFSUNcPgjOv1yMnHEAZdhcD0HQUgt9gXk1AlWFkWkGBuG7cPHfLwQkiBisQKvmkVuwrdmX2ZbBEmPWVakcHbPHvEQhNMIcUyLEEyWkjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946837; c=relaxed/simple;
	bh=TRh3kCtvO58B3TS/ro9pEJNNo6FOlD9/z7qzRrzSlqs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSTiHTSzW7uqMI8moB9goe5Phb6V7LTIvaNfC6eC+qKwzN2rpN+HHCmZDAIGszUCfUZ4pQgTJFxo9K1AgqRdcq06FBfY9Jxf2UKlbXeOWtVij5ZcRJ0IFR9B+j5v//vTMBS0Z6dsQw+P0Mw3SiptVqLDPF8lhKKzulvlFZiQ32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Aex1PcL4; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70224a923fcso439547a34.1
        for <stable@vger.kernel.org>; Tue, 02 Jul 2024 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719946835; x=1720551635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRh3kCtvO58B3TS/ro9pEJNNo6FOlD9/z7qzRrzSlqs=;
        b=Aex1PcL4TQzx8xBTycaadMgX5n4tITaDJ7ONqUNBdF1vjeiOMgSC7gfpdYgMNs2lpz
         sN8BIfgFJPooNk7fLnAPOogWzWhcLP/V/GdwoECSQQ1PBIpuB69W9QQKCLX8UVGKuOV/
         hoy2aSRq+4RZcb1OEn93WMKX2ZPMXrFFYB+x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946835; x=1720551635;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRh3kCtvO58B3TS/ro9pEJNNo6FOlD9/z7qzRrzSlqs=;
        b=rsPfB5WHUXgCYOHuzXEmUMSLCJP+XU0jzDndLJumJ2RpUMbdg82UGujdPX7QMGwSnE
         9OfVmTzRdTJX5/cBBo48b1zP1OBNJTQBkUEumkQCw/oyZG01aG83ZoIQ+CtSNki+Zmf5
         CHn+6RNFaFd5O9TtmGN3etGwnh07Eb7MKrzGH+3HzKrYOpHZEuH4GnIj8T+vIsBMpVGj
         ZXgHGUWGpFUVCWVPmdJEBL8zHGBUKbpZYIiXc2wWawljo4xI469rzNhk4FOTbjYh+nMo
         WDE9X0+1Se1vQiiRT2plIj/vyJlbFZHssouqsa3zVTzEdIGAcWF5vdGSz5AAGNYtpi9s
         5X8A==
X-Forwarded-Encrypted: i=1; AJvYcCXJX/+j6Jpr8Adk93cIVvXzdlsN9jIh4UDisds1u2lYeMc3mmNNkBkRhVfPOd8UWPaDmxRU37HIlcd7C2xWtDBw+QJOOmQH
X-Gm-Message-State: AOJu0YyvEf+Z70QjQzL4uTqwhICvX0756t0tcBYELlpT8FGsLloVqsPS
	xG8AYpaRptK1aAclH9sjlmiN1mTWn3hYTBTMXYpqgiJEqXWfM1G0XvtClNfex+x6epbm2+BIze2
	kL2/FG2QaVQ4g8jkNhXB4Vj564m5cjCRjlTIu
X-Google-Smtp-Source: AGHT+IEuctwteLzkcWtPEA88NJi6Q3ar2tx3qa3jOR7L3cOw0C0DH0EuKI1yUKU29vx9JV4sFz9I67UQX3NV/JxAMfc=
X-Received: by 2002:a9d:6c56:0:b0:702:526:284e with SMTP id
 46e09a7af769-702076f2ed8mr10449874a34.33.1719946835587; Tue, 02 Jul 2024
 12:00:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 12:00:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624-usb_core_of_memleak-v1-1-af6821c1a584@gmail.com>
References: <20240624-usb_core_of_memleak-v1-1-af6821c1a584@gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 2 Jul 2024 12:00:34 -0700
Message-ID: <CAE-0n51SfZiQ_XnPXYrG4Fyu=H8xDc0zpJ_Hxa+MrFq8V8PXTQ@mail.gmail.com>
Subject: Re: [PATCH] usb: core: add missing of_node_put() in usb_of_has_devices_or_graph
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Javier Carrasco (2024-06-24 14:10:06)
> The for_each_child_of_node() macro requires an explicit call to
> of_node_put() on early exits to decrement the child refcount and avoid a
> memory leak.
> The child node is not required outsie the loop, and the resource must be
> released before the function returns.
>
> Add the missing of_node_put().
>
> Cc: stable@vger.kernel.org
> Fixes: 82e82130a78b ("usb: core: Set connect_type of ports based on DT node")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

