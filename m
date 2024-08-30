Return-Path: <stable+bounces-71661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8549665F7
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 17:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE1EB24230
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E31B5EB3;
	Fri, 30 Aug 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQF526jI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E81B5EC9;
	Fri, 30 Aug 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032713; cv=none; b=B/RhnTQ1NuMELXYVLqx6yLiaJLAzf3qIlRIIT9NZ9ZnRhNHWsuIRKYI6l8dplgBNaSofl6Qt5PmeERjunlqR5Qxru5rYPfHTVTLU+KivaI8W+Od+UQudxNbf7qekQXdahQ9V/9TpHHFs0vGaEJRW3XhALuXR9B/mOD+4P7gHOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032713; c=relaxed/simple;
	bh=HqClUW0y4TPjRV7tFoBqmvUM7p96BH5eNpQ76g7qgbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=nXdjjkKOmDkb2KOWxzYq3YElsYm/bO577G4J1NAkaHir6zrZB0UtFwk+6OKqIydLFUWRSuOcq3AB+6RNV3n5GWBhd2o3E29hArb+qcDWip6YOuucBSn4nsXfowWMwIMskMQk3Rs0ZAgDaMRgCHshfU8hGnwEfrbtHItJejl2o+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQF526jI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5343d2af735so1897422e87.1;
        Fri, 30 Aug 2024 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725032710; x=1725637510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx/lCrTpfSvdHUgVk44KXjqtVq3fG6KgJGrfLz+31DQ=;
        b=YQF526jIPYdLo52bs9ieyfVwwRrXeZziMTdSXU8Pa6A3UPsiOUV83Ancvuhb9NbHXe
         GDyjDjP9Ulq1puxHdIq5Nqk1IJcq5t7OBUbFLzHqVd0W3dVqtwBpf2hiYTd0T9mviyzT
         VqAgtqCzg6nICIGBO+zbjuQYJJ67AEMzsweCTV5GJQY1aRg8MrXfToXMehxzUx0aZgbq
         jxZiPi6yw4vU0jPzALr8ok0tOutFhAKOs2rxAH2ObTYVr9yxFHJUfWsNBA5vSz54gxAT
         0xqJsEcfaH3z1pnt87Pnlzk6GVAXMwvvYCFG5D5WCkBHKXhmWaGQo5hMC/SQpMEkVt4J
         H+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032710; x=1725637510;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx/lCrTpfSvdHUgVk44KXjqtVq3fG6KgJGrfLz+31DQ=;
        b=B8RzdZ7D17/A2mfNCgFK2e41d6CJisaDo5AcVS/4Cqcl9oWopmqlS6OsWMscMqZtJU
         COcO39G+cMDR3ciMm20rm9OqhURTPhhXVhJoQqQYzUDuKyYMzyBau8DYqA1CSIfFutFY
         yT0f6MchybK0p7ftT4Yh2qWIg6M9G+f2rJMboQXAWYeCG6WB6JR0xInp1g5Wqb4oU/61
         8LX47hvNkhzGfzzPgAWxNyS+yfpN5J7aqX/Tn5IW38yBETyaGeIWZLvwTginCo/Ogflc
         9hB8AgFoneugdY+pcvaae738tXmAxfZRb0ELrEIf4qRQRXRdlcwSbubA9uHLN12/A7wr
         fqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjGEiLTNcwJRzsjuTeoi4atCJiAit4OoIJXjK6G21X868v4RTSVGQkVHmkmgoZBxoVLIgUiWpQ@vger.kernel.org, AJvYcCX0QX1zTjIRDCau/EPHYRz5/tWao2w8KggMQ4YaxcLiT9gVJsu4mRewhyTBVovWfaxnbm8UmPj6L9TJs2I=@vger.kernel.org, AJvYcCXNP1RINHSqMnpKWemgNm3+XMFhHeVhxTVok9SB1tznOfDTmA8J7lOTVTX6F+BbLeWe44bPMmeYLy+K@vger.kernel.org
X-Gm-Message-State: AOJu0YyNS0f9wkgS8/OnHouubfcFJuXDbZUg/ijr11MCo6fDkJOuMfM7
	SnvicyKR/m3ckqeglbin014WRCinRwTlJK/Np3KJ43XSNJ++Ihis
X-Google-Smtp-Source: AGHT+IF/RWISTslY+pNUUnbN+pc2mYiEfpgOldaEiU6kT37eEG8cCnaYn2ostIaybYUKADsBJbPqSg==
X-Received: by 2002:a05:6512:159e:b0:52e:7542:f469 with SMTP id 2adb3069b0e04-53546a56629mr1760359e87.0.1725032709314;
        Fri, 30 Aug 2024 08:45:09 -0700 (PDT)
Received: from foxbook (bin33.neoplus.adsl.tpnet.pl. [83.28.129.33])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535408286b2sm660237e87.172.2024.08.30.08.45.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Aug 2024 08:45:08 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:45:04 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: pawell@cadence.com, peter.chen@kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
Message-ID: <20240830174504.1282f7b4@foxbook>
In-Reply-To: <PH7PR07MB95388A2D2A3EB3C26E83710FDD8E2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> Field Rsvd0 is reserved field, so patch should not have impact for
> other xHCI controllers.
Wait, is this a case of Linux failing to zero-initialize something that
should be zero initialized before use (why not explain it as such?), or
are you suggesting monkeying with internal xHC data at run time, in area
which is known to actually be used by at least one implementation?

There is no mention of Rsvd0 in the xHCI spec, did you mean RsvdO?

Reserved and Opaque, 
For exclusive use by the xHC.
Software shall *not* write this, unless allowed by the vendor.

Cadence isn't the only xHC vendor...

(There is no mention of "Stream Endpoint Context" either, so maybe you
meant "Stream Context" or "Endpoint Context"...)

Regards,
Michal

