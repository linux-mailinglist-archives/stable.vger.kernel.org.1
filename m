Return-Path: <stable+bounces-113991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3498CA29C0D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9EA188696A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639FD214A7C;
	Wed,  5 Feb 2025 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUOMPBFy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923171DE4D3;
	Wed,  5 Feb 2025 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791922; cv=none; b=N6G+yb4UpJ44ulz1m5VBUTcxHI+/zb7QVXGHyvU9JcgELfGYTRqvwrw6sYh+d/Tcy68Zc4xjAXqWEIukMES0pGrFyC2ER0ZjoWIA4rsLvir8Krqdvc7l/EmeVOiUHlo/VGHduQDU7vOHecrVmZuQMbtYmVzBX6snxo9BGIKgOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791922; c=relaxed/simple;
	bh=HrrpasWyuwG+NC15Cx/xnTL7cEj/zBNpmMcgmzhxV0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=Y8+sNwW4d17Y4FC9w6EcFrRgqh4WmrNsY5+yd9PG107ohFHO5iQ6junV/aSoHO9MC1YDyWq0HDJ137IMZcBV9Chfj5aLBJMQPYGB/0NV9lhRrfLLhYM7JsWSjlWX1bBRVMeaRV5IfVJWGzIyMzw2J9Zm2httJqaYpZ0N3AOwym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUOMPBFy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab69bba49e2so40217666b.2;
        Wed, 05 Feb 2025 13:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738791919; x=1739396719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83ozoj5c/jHHLPQR0gxR8lx/Hi0ZcnYkDPH3CyJmhHM=;
        b=MUOMPBFyH9XUe86TTuYdo9/9mgomOSa3/lDK903fYb81QOncYbibZiQ9DmLLgVsAXJ
         kXu2+YJRJI6vdyzfP43wXqWh4qq0HfVjp1UIUehycO0YWURCECHVXEIaY7Q2wmINyRu1
         rNb5dW0XWZ442nRyiixVU86K6lAJrNYrqDgLsucQNuBHXkjRpnIlybr7kqHKsrAfdafm
         Q5AoIob21WUMbw6S6JRoM64r6lr6FKWwRRHNEIdWtztMAJG5YELO4DqYbVLyi2h7AcE5
         KU60M5hFb8PNUYy3FSbJg6ye308Beg/rBaOqhYUfpgxLfFDJDoDKIxGBhLRcchrYxkxQ
         Brzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738791919; x=1739396719;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83ozoj5c/jHHLPQR0gxR8lx/Hi0ZcnYkDPH3CyJmhHM=;
        b=VMiP5DCy22DRZ3VqXGT4wcVJcc0YCOfQMMXQ13XPD8xcXRyHuFns46i4vExTEp/fBH
         ZLzbdsLdEBDeWKQYUsHzjT7kOU0caMkjPTlKvbo+rlzt8v7ezLaFOI7CeHs3h93REJEH
         RhJqSkxweQ60ADVyq1i9L3xwnLJFwkIt5x+OWwCBgF+9VJ76LZbU5+U3yQwI79TuuXvP
         AE3ptnetuMsvgsNLN2a8iIUt2yXZ6+WAGL3/i6tK1AZXVRjw/TDQHUaclxOQbeY+N6dn
         PP7nCfL+X6ITEw0at2IshY3ia3WWe8q/tAR3qBlCM+yP3YU6Pdi0gEuw/bOyhpSNYB6j
         DDlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBjq4EgDdyHPVHQXgwy9/QrR4Yx1w7lQpnogXCDr4wkcZ6u9VPnQjh1j6PvleNZkkSuackWfzr@vger.kernel.org, AJvYcCWpo+H/RbdrxoiTdjl8XywHqHDc0CYhoc3+kvYm6Tfnapmv+q7MYjHUGoTVweTFAkL+fhr3ijHOTj1v@vger.kernel.org, AJvYcCX/bQiHQCn3sEERsJWhHgs1/bpiPDWm4fbonmOKIFrnQnFfzHQGwnegj8OcTpEzL2bL9W8EtwNAwELMAqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+P0bD9s0i+9H+uAP3I9YS98hcv1NMXMD2HM9j4i61d5zpmP/
	atj6bgO6BNSLsSWfREf4p0ypO6N1esqnsvogh3rhh7M2Ly7ul8Dw
X-Gm-Gg: ASbGncutqk1bkTxL4SA/nCCeNM/u8bP1d0m4ajVIwH7zsRUcfob/wJqUxtOdgd83xlK
	qFRzP5e+cKykMxH1DcKRcg7ZwvoI7RiAW0wylRtPpyFhjiB6I6MSVK7NCcxvuYWlhU0KAzIfTUe
	+kU6WjYNct1iU6o9CtQ42+x+Iw/H20iXfjCfZf6yE2QY+CE5nnhSl6XLrhZndpdOHO5e6ed4GJ4
	RVagEaK7MKlFG9onsc1fR1YOS/jFj5dpfJnGOpZj53eXJSV9GFd3ur5z7kL9ZxQruXPkAssvL4R
	4tjynyeJIKCbT/Fb3/qT6YftB2gYQH0b
X-Google-Smtp-Source: AGHT+IEPoIk30WWfA4BXz8wbNZOuVKWR++S/AotVQ2B18Pc/DY7ndJq6yoG435vz61ChOqXemub6rQ==
X-Received: by 2002:a05:6402:13c8:b0:5dc:80ba:dda1 with SMTP id 4fb4d7f45d1cf-5dcdb711b67mr9092208a12.9.1738791918514;
        Wed, 05 Feb 2025 13:45:18 -0800 (PST)
Received: from foxbook (adtt137.neoplus.adsl.tpnet.pl. [79.185.231.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dce49b0661sm875416a12.25.2025.02.05.13.45.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Feb 2025 13:45:17 -0800 (PST)
Date: Wed, 5 Feb 2025 22:45:11 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: ki.chiang65@gmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
Message-ID: <20250205224511.00e52a44@foxbook>
In-Reply-To: <20250205053750.28251-2-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

>  	case COMP_STOPPED:
> +		/* Think of it as the final event if TD had an error */
> +		if (td->error_mid_td)
> +			td->error_mid_td = false;
>  		sum_trbs_for_length = true;
>  		break;

What was the reason for this part?

As written it is going to cause problems, the driver will forget about
earlier errors if the endpoint is stopped and resumed on the same TD.


I think that the whole patch could be much simpler, like:

case X_ERROR:
	frame->status = X;
	td->error_mid_td = true;
	break;
case Y_ERROR:
	frame->status = Y;
	td->error_mid_td = true;
	break;

and then

if (error_mid_td && (ep_trb != td->end_trb || ETRON && SUPERSPEED)) {
	// error mid TD, wait for final event
}

finish_td()


Regards,
Michal

