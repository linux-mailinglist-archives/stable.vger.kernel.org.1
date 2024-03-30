Return-Path: <stable+bounces-33793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32698929C2
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6990D1F21F67
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F61C0DE5;
	Sat, 30 Mar 2024 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aiO52C6y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B1179
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788402; cv=none; b=paQQ7waoD1byFbJWClhSivh/sbwrnclReoE4nwKCEQ4lzh2EGqESXKC4mDKIOms0sKtPUsQOeNyoBqlkPZv/1N2BzImwbUl1uZRhhPpgfbb97novLyr7zUw84gsf7KRgF5W+ggfmZ/eRm7jkoVrOEyioIvCAq+++Sf/oVrbrkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788402; c=relaxed/simple;
	bh=8Hnsey0xqsyMgcmYDnb1rX39LwxAk6bHXskAx9S3IZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUs/y2YAm0Wrip6a+1MG1O3sui+m1jNmgTpkLdLBXucx4fnKVyk1lGr+PNoFXHtnRAcY8P/Fv2q8XM3yjf9eadHHiaWJUaQmG4eeh3UqfGUxAefGJsbJ4eBomuo9OE34M0R1XA3BsVRKwhyzfkoHuepbZKur2LmSe9eMhbzhLOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aiO52C6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADBDC433C7;
	Sat, 30 Mar 2024 08:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711788402;
	bh=8Hnsey0xqsyMgcmYDnb1rX39LwxAk6bHXskAx9S3IZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiO52C6ywz5FLEBVVBHT89VSef0IAEDQzU8Sk/8g+s00/eFR8w/peFAl5yJAbpodd
	 OJIFfjou7NYvnEfn1Oap6K1pn6QnbVZZAluDI5noZDvrWAoVvTf5jtw+fyfKi3J5va
	 e3RGEqwVurG2bQE7Gdn8S15kFlxps/S8U6TeUKOs=
Date: Sat, 30 Mar 2024 09:46:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH 6.1.y 1/7] Revert "vfio/pci: Disable auto-enable of
 exclusive INTx IRQ"
Message-ID: <2024033025-acquaint-bovine-a777@gregkh>
References: <20240329213856.2550762-1-alex.williamson@redhat.com>
 <20240329213856.2550762-2-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329213856.2550762-2-alex.williamson@redhat.com>

On Fri, Mar 29, 2024 at 03:38:48PM -0600, Alex Williamson wrote:
> This reverts commit e31eb60c4288ecbb4cc447a8e2496ea758a3984e.

That's a fake id, I've just dropped the patch from the queue now,
thanks.

greg k-h

