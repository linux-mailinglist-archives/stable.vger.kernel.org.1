Return-Path: <stable+bounces-119848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF2A482B2
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 16:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526511888D68
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B026A1B1;
	Thu, 27 Feb 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="XXUlFRJo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE425EF95
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669142; cv=none; b=eTpwGeD8r/ejhf89yHZR+Nn4Y9VxjDOpjpooVtp1nbkdNclaoOXJQxxIAMhrL4DU7eGC+9mykNMeh7sR/XBOr36kj/BV7M2+W76yiy2hw0s27+SaMB9gGo+P+9lw+eKWLAvVAzTaAWvMwPyVV+pSZ2E9nZJkgrMR95FTsRYiJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669142; c=relaxed/simple;
	bh=biSojK3aYrH5alpEFwNMM02JPcIaJeMqtWJC7TMKk3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz5+N5Dk0zmoyIldV/R9mCmywetHazsNRXIpIgKmjHtkv/PWtRD4Ewu66VYj+rV4xm/HZxEge5aJWWTnamyy2niM8b1Vhx/4sDqjSGvbENRqxQMuTM7H0irfDE6Bsw4iHU7dedobu6ffghwLKV4YCYWr+wbnNzYuoYCFsOUERAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=XXUlFRJo; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47210a94356so7837381cf.3
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1740669139; x=1741273939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNx8YZQIjNLm0mZInU+TMEOrRGJoGKSTKhShcPs50Ok=;
        b=XXUlFRJoW4wPfZjg4H8o/bL1jqKGTsvAQDXVcpbrlaItWHmXnPWFTqZTFxFjRzz0Ih
         D//Q3WhQV9YpUiT/tPuD0pgcK0b0HkQVaf/LcQFWYVy8Ir+ru0QjL/y04FTgXMmeGs/t
         LCESLlrl9zCZYwhyZveCY9ojGPNKloFFTaH7j86/2pfpRwgoZmGnV00QDNg14XeEZZnY
         mC3it7/dD7NCFBM3Kae4RVxNJA2xRl7EEiGOTWP2bJGsLhRN+TESQAul5PqCuyBUBNO+
         dQVcOpNmtKMwODMO4sK+5VWWymcGamp9SVW0W2XB4WlWPJWQgxwNyv7ED2jHotrvikI8
         DJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740669139; x=1741273939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNx8YZQIjNLm0mZInU+TMEOrRGJoGKSTKhShcPs50Ok=;
        b=o0oNdjcLWltNXnxOhEoQ2zZ2Cg191Ht0GvsIMKcevvKvcToJ77gIs70aAADIUCOhj8
         zQMLVdbMKbA8l/B3rNbMzxnnobJ8Ujo37/TXXVpN95IFHuHY3EONwnrwJ8nlwm2Q2rIU
         PggG7ZB5e9WzdQLH6jTF8fxbhIPJa4LNduxo5VJkDVJMS2puGJpVhP2uKnDePReMbXVm
         Fd/l9atXH1n0+JElpDbc9PevA2VAxeqP0+L7wYF6kNR24hIkCQ3ES0HfeG40D15+aVtJ
         w5jKme9QXgnSEoTjDNONDe4pG/RL1JQSagXkNQ2vw2AM9jAtYu8J02BXhSE/3+cgTLMD
         PKgw==
X-Forwarded-Encrypted: i=1; AJvYcCWR1EtLZubPkHjEHCIJe9IFPnX+et2lk1o5qBid6hLE6FO+0FHol+80+tCySOFyiyn+UpTzHdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEmlSLdwsLdp0UNKscXL4faGOXtKazPjRlmfLzkIufZnhZbRL
	9w9JpCQHJAVXi380M7dQL+QLpJ2dIc7TTHiAK+mhrsK+QQLurRgzUXEkm3hICw==
X-Gm-Gg: ASbGncvk9QmywCKU/Ql7CEAq30/eC30aUODR+r+GpmlZzPtiTsTaK1VYxDVQtAZ3D96
	TvLWWI+cgovoPPW5TbQtKh1HzKhK+ynQvb4PSWwyqV6jfQGsmhc09lafrKbyUZKi59EnFRt4j12
	2cji3TnKTfla0bNKdC2evWq9yX8QABv1KoxmObBacKUzJoHdRXxNyeEBiIhPJeFf9dF7btkJ4Zv
	uzxQA3+8URFnDQ1j8VtaKbLKH96WmX0hP+d1yiYejaaaab9+vozgHBF12/GvgeQAuMUOcO04sGD
	WDlEipn2au55CnXaG8/aWrHddhekbbRUCfMY6oCPlyod
X-Google-Smtp-Source: AGHT+IFpyrujk1OpBqdflL1MiDLfKUylvOBhU5A06YFvWgA27FYmaDjkhww5yqqypilPXGwM0RZvjQ==
X-Received: by 2002:ac8:598f:0:b0:471:f272:9861 with SMTP id d75a77b69052e-4737725c45emr159740651cf.33.1740669139443;
        Thu, 27 Feb 2025 07:12:19 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b5ee0f4sm11952951cf.30.2025.02.27.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:12:19 -0800 (PST)
Date: Thu, 27 Feb 2025 10:12:16 -0500
From: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"make_ruc2021@163.com" <make_ruc2021@163.com>,
	"peter.chen@nxp.com" <peter.chen@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Eichler <peichler@cadence.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: xhci: lack of clearing xHC resources
Message-ID: <6034ee47-7f95-4917-b4c5-fa9ab6078f73@rowland.harvard.edu>
References: <20250226071646.4034220-1-pawell@cadence.com>
 <PH7PR07MB95385E2766D01F3741D418ABDDC22@PH7PR07MB9538.namprd07.prod.outlook.com>
 <a78164bc-67c4-4f31-bbe1-609e19134ddf@rowland.harvard.edu>
 <PH7PR07MB9538F28D5F4F6706363CC78EDDCD2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538F28D5F4F6706363CC78EDDCD2@PH7PR07MB9538.namprd07.prod.outlook.com>

BTW, since the patch doesn't touch the xHCI driver, the Subject: 
shouldn't say "usb: xhci: ...".  It would be better to put "usb: hub: 
..."

On Thu, Feb 27, 2025 at 07:05:17AM +0000, Pawel Laszczak wrote:
> >Doing it this way, you will call hcd->driver->reset_device() multiple times for the
> >same device: once for the hub(s) above the device and then once for the device
> >itself.  But since this isn't a hot path, maybe that doesn't matter.
> 
> Yes, it true but the function xhci_discover_or_reset_device which is associated with
> hcd->driver->reset_device() include the checking whether device is in SLOT_STATE_DISABLED.
> It allows to detect whether device has been already reset and do not repeat the
> reset procedure.

Okay.  Please resubmit the patch with the changes we discussed (and fix 
the kerneldoc problem pointed out by the kernel build checker).

Alan Stern

