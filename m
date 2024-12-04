Return-Path: <stable+bounces-98242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA459E33F2
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 08:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0AFB22E6C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 07:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA3715B97D;
	Wed,  4 Dec 2024 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zk93e5Gt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7770184
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296609; cv=none; b=MA2b26RTccjQMtPxL/HVo5BfFq3Qt+K00YshVB9kvu8mp/sce9z8FTwm/zv8SJF4u5Z8jqmsVJmCWAuQ+QIRTIxMZNmR6QWMzHKzpagvoX07avCSW+T4kx1GA+d6A0rGFtIfHu1OIOomBMmpKdemM4LLKMe/8XSyFxwODRE3GdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296609; c=relaxed/simple;
	bh=OyLR3bE/putp0qpg8+pwfz01cSmMLOjPgcz4ysL6rjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOX8fJmG6tSN8z+XrfalMVck4Lz7FAP3PHuTP/rqfubVIe2O5N2GtUQRiwddR9mzDfANuQZ/ets2OCksiLpV9+ndzQVH/r/yR+L5nDBF7b84orA+Q/nTIWT2fAAXTcoZhanZxo+Wc/G/FdHC5Rsq3GsxGSb++1ttxTY/6hqRLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zk93e5Gt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215ac560292so24715685ad.2
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 23:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733296607; x=1733901407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jShvVE3mVoX8qZqeJ1TxXuJz9big4GN6ZMKFhtrVj6o=;
        b=Zk93e5GtZWxx/KC3KD5MLhEK3CYWpABOSSQF0z4YTERrc0kpxJ8Vg8zsNspNaW77nL
         X8HszgNT0Xph2Gbh0czvdDE6odQTBBpwIqpjL9kdhltazulw5Zo7X3pmcCHBEfz1jRD8
         NPGN4z8haOm4BAmVJ6CRl5Vn5ZevTw5+N/+7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733296607; x=1733901407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jShvVE3mVoX8qZqeJ1TxXuJz9big4GN6ZMKFhtrVj6o=;
        b=Jq9lWdbultvzJ8c/iBVS1e6+RwOx02sZV2i3oyZd3onXIzOVUvi/9aUC87R69SvaFU
         l5wokhjWtFd87hvUDHb67pmUv7y5YdwOwosETMVXY7+ZUIPX1XFMRBw+UFv1RwM+FExL
         amsWKNKlXqTOH6as7G9Wxn7hNqh9Dn20qklyJ7gcV5tUlBW3AvshLIJE2IvF38yBsPzZ
         LOdX/qmCaYe9mpyMql3k8wxNQ3Xh8yVNHO8AA3n2Obj1EYkQNnpEsgMAAV6ZU6Fno5/i
         8UmXzc4yD/Ti+3EbjPe7ny90ssc+/ZIY3nFbNfsMHpgxNyuK6g6JcQS+beINePTT1rr9
         1/lg==
X-Forwarded-Encrypted: i=1; AJvYcCX1HLfQ1NTAd2ocfzKBZ1VVmq/Fc2iV7t3q+k+yEBxcTC7RJWLa0tSTWDRm89PACoMWC7iHYao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGr/fUlLP9aKWl9XDJcE5cEJZABnLi2UVWw1SXFEdN4RzC5Ga
	9jWn7MAru3nGnnwdNRzrqRGnWXx8r1DqBnVifar84Rpu8/BZ2W1qBCNDYiMdJg==
X-Gm-Gg: ASbGncvp9gLw/DjH7EWPN/D2cKt7FPcAQB/egVG/55L8NFbmJzq3VGQ0r4U1/kFZbOL
	po01ENvHLOT02DWtvddXaX+NxYQwQhTEv2Hx5/IyqHfH1z/PQ7Nz8ZAsTKPyGd4Q4BD2JIq1ms2
	EXVpagpXTInBv+ZPHKECvHE0iqU2fwlg3dP0vYTge5ItjAcgqxVyDDFlNkQVY9UHuyVG6ITMUYo
	MhprVJAvcnASne0hP+jdMrw1aUVDJOmEIBOa9AGWpQJPLnSHg==
X-Google-Smtp-Source: AGHT+IH7MwYL3y42hcABxkEztmhq2Q67GkUb6bnHPA6IoXTpf1xN74Ohq2ewMXk/zuqxOdIvT2pR+A==
X-Received: by 2002:a17:903:2447:b0:215:431e:e0f with SMTP id d9443c01a7336-215bd0cea0amr73075845ad.28.1733296607076;
        Tue, 03 Dec 2024 23:16:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f520:3e:d9a1:1de])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155be9b42asm71320345ad.135.2024.12.03.23.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:16:46 -0800 (PST)
Date: Wed, 4 Dec 2024 16:16:42 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Tomasz Figa <tfiga@google.com>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 207/817] media: venus: fix enc/dec destruction order
Message-ID: <20241204071642.GH886051@google.com>
References: <20241203143955.605130076@linuxfoundation.org>
 <20241203144003.826130114@linuxfoundation.org>
 <20241204031031.GF886051@google.com>
 <2024120433-paternal-state-098e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120433-paternal-state-098e@gregkh>

On (24/12/04 08:10), Greg Kroah-Hartman wrote:
> > > From: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > 
> > > [ Upstream commit 6c9934c5a00ae722a98d1a06ed44b673514407b5 ]
> > > 
> > > We destroy mutex-es too early as they are still taken in
> > > v4l2_fh_exit()->v4l2_event_unsubscribe()->v4l2_ctrl_find().
> > > 
> > > We should destroy mutex-es right before kfree().  Also
> > > do not vdec_ctrl_deinit() before v4l2_fh_exit().
> > 
> > Hi Greg, I just received a regression report which potentially
> > might have been caused by these venus patches.  Please do not
> > take
> > 
> > 	media: venus: sync with threaded IRQ during inst destruction
> > 	media: venus: fix enc/dec destruction order
> > 
> > to any stable kernels yet.  I need to investigate first.
> 
> What are the git commit id of these that I should be dropping?

Upstream:

	6c9934c5a00ae722a98d1a06ed44b673514407b5
	45b1a1b348ec178a599323f1ce7d7932aea8c6d4

as far as I can tell.

