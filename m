Return-Path: <stable+bounces-39386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC18A42AC
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215011C20DA8
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E526446AF;
	Sun, 14 Apr 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QaeLqDAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69431A94
	for <stable@vger.kernel.org>; Sun, 14 Apr 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713102087; cv=none; b=XBz1lnQjZ9VEn7wPYE7jQy4hDEJaiLSYCyijHuh4jRioXIkcXP2apjg5/Yk4xKqli6q3Irn08g709e/erUjoD6+JKI75daryR1FuFt4lbX/e+dZhZfjU0I9ghF6ZQ5BUYx1qiU2CIzZbpR3l6IKwwdKlupblAaiXr/AiR21B/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713102087; c=relaxed/simple;
	bh=e0of384HoN9+3TddphB8KHvDz7095Prk8L6S3+MtfzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4o2zWcrCJgbnBaUaXLbiVxz0fN8/ZgfvHYUwUSaq593frTQ6oGUAmZS0pO5NOIeo3Qn2QQEF0C0Lyv0Rr7BaMv6QBP7ZSyNKJdBr9D/hm3P+iFr19ZoqJ6pl/Hm1GEtstOiPtLHkgzOeU7RUMRbkDfGWn6CUb1HTgsrcQVTIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QaeLqDAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C62DC072AA;
	Sun, 14 Apr 2024 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713102086;
	bh=e0of384HoN9+3TddphB8KHvDz7095Prk8L6S3+MtfzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaeLqDAsnVm9xb0ZjsENa8QAmIkyW2xd834Q5J2qDSPFqWD6tkTsaWhhMv5GS2gMn
	 iwh4qF66n9HvMvEcZxoDPeodUmO0Jhq6o2+vIQBwoHZxvsvtQKUYIMSR8b2TT6QXtT
	 jGtWb1OP8jG+bOWsNxuHGm0wm1GLZHDSmuiwsg64=
Date: Sun, 14 Apr 2024 15:41:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nini Song =?utf-8?B?KOWui+Wum+Wmrik=?= <Nini.Song@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] media: cec: core: remove length check of Timer Status
 solution applies to 5.4 and 4.19
Message-ID: <2024041448-contour-oblivious-2158@gregkh>
References: <KL1PR03MB6225011CAE293E2DBF6C3B8E90042@KL1PR03MB6225.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR03MB6225011CAE293E2DBF6C3B8E90042@KL1PR03MB6225.apcprd03.prod.outlook.com>

On Fri, Apr 12, 2024 at 10:14:41AM +0000, Nini Song (宋宛妮) wrote:
> Hi @stable@vger.kernel.org<mailto:stable@vger.kernel.org>
> 
> This patch has been merged in mainline as commit ce5d241c3ad45.
> [patch diff]
> [cid:image001.png@01DA8D04.BCD8A070]
> 
> Because of our customer used v5.15, v5.4 and 4.19 for MP production, which requires this solution.
> 
> We need your help apply the patch in v5.15, v5.4 and 4.19.

It does not apply to 5.4.y or 4.19.y, can you please provide a working
and tested backported patch so that we can add it there?  I have now
added it to all other branches.

thanks,

greg k-h

