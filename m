Return-Path: <stable+bounces-28318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E6E87DF7F
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 20:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB841F21029
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 19:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E701DA20;
	Sun, 17 Mar 2024 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PK3tQeS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12441CF9B
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702458; cv=none; b=Bzi9OLj10CzZbeJY4yG3PBbjLgnsEEvOVYewK+NDtyp1F8u11hqu2U8sZzOLV3kYc9LBsrCoHfApCM6BYZC2qb/H03eZ0GgQcjNVUQjTDKCNcXP3APqfQ/aIFQMkFLWe1GimMlNcSkiNkva6+MNreQwls4kq1DX0ynWCLbukdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702458; c=relaxed/simple;
	bh=lQd+LEDhVHgpgThGRl95eknv/H2caltM5R5eOb4AB+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL0TaYrz9ggyjqX1tL+D1hJ4lhauAHr7l7WAcovVqJhavFXXQ+uER34FVvW8Ri6QL2ZiXRHDmB7TCV96B6H9WrXXq0OGDcFx5nnCWH+5cJW14NNAcQ4oBGODQlCLvOHNjrV02at/4sWpBDGN8CGO+jlpQxvsI9SI2gra25wCDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PK3tQeS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D65C433C7;
	Sun, 17 Mar 2024 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710702457;
	bh=lQd+LEDhVHgpgThGRl95eknv/H2caltM5R5eOb4AB+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PK3tQeS3W1z3iCpNn6o4NcW106Eh5U8TJq46twYQS6jaiUh1Hna8QUV3UkdouJpCa
	 qcvhQLNlTYImrvQgQe5DU6cxJs2uuHt1bzOzRBeF2xFusGEoBhtdR7Un3iojTZB04d
	 R9rwKNxOKs2dJKFAm6WCncJd0fZe9x1s2Z4SUqqY=
Date: Sun, 17 Mar 2024 20:07:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Max Nguyen <hphyperxdev@gmail.com>
Cc: stable@vger.kernel.org, Chris Toledanes <chris.toledanes@hp.com>,
	Carl Ng <carl.ng@hp.com>, Max Nguyen <maxwell.nguyen@hp.com>
Subject: Re: [PATCH 1/2] Add additional HyperX IDs to xpad.c on LTS v4.19 to
 v6.1
Message-ID: <2024031724-flakily-urchin-eed6@gregkh>
References: <20240315215918.38652-1-hphyperxdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315215918.38652-1-hphyperxdev@gmail.com>

On Fri, Mar 15, 2024 at 02:59:19PM -0700, Max Nguyen wrote:
> Add additional HyperX Ids to xpad_device and xpad_table
> 
> Add to LTS versions 4.19, 5.4, 5.10, 5.15, 6.1
> 
> Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
> Reviewed-by: Carl Ng <carl.ng@hp.com>
> Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
> ---
>  drivers/input/joystick/xpad.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

