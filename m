Return-Path: <stable+bounces-62815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B391994139E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32459B28F1F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4B01A08AF;
	Tue, 30 Jul 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DEgcNhhU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D61A08A0
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347441; cv=none; b=hyNp1uSxZz5Xim0doZFh9ol0XMDQaPxq73tfWMIIdbcwfDHi8mlDu/Chuk+uSgUAQ2wSOlQg0vOKXEY1b8SHH+6F936rPuHZ+edxFyqXbB5WYQfdlH/eXOMfwvgoC/+M3IKM/tZUQa4HTfetNrs0qnmTx50QSVH7DB7rh4WLEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347441; c=relaxed/simple;
	bh=loBy1DsX+oBjC5m2WQIQCE+EQST9a6tu6tyRwNI3KzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrbTHDxlS0ZthIVShsiOvrVsWkpjQ5Rksx4PJDnPVyVUY7iKpT4UZFrKX0a194ulZ/YKWYyugPRsX2/yt5mizpXB9Akgtvffb84IBaQlUdVPLlcIGnVZeel4cjHUJf060/7QySppztVw5nYn1xn5cMviXZrfxd2NPLe2cx7tJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DEgcNhhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D134C4AF0C;
	Tue, 30 Jul 2024 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347440;
	bh=loBy1DsX+oBjC5m2WQIQCE+EQST9a6tu6tyRwNI3KzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEgcNhhUdX1FUFRaTGyh+J0tqeFmbKohnlJk0SLhMVDOzoQjvWAv5ozVr6BnX1K8L
	 H+qt5gqWLkWKlYKqyyAvNxbHlP42n+9Xv+LZUuO4cZ151JKx9bvI8ERXD4r3Z3mOr8
	 URUEjcw+jtE10K35mmFmRWOFjGQfNPLpFOzvV2+w=
Date: Tue, 30 Jul 2024 15:50:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: stable <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6] minmax: scsi: fix mis-use of 'clamp()' in sr.c
Message-ID: <2024073030-facsimile-shape-d069@gregkh>
References: <tencent_581E12207F4CEF552409D708@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_581E12207F4CEF552409D708@qq.com>

On Tue, Jul 30, 2024 at 12:52:22AM +0800, Wentao Guan wrote:
> Hello All:
> 
> Please apply the upstream commit 
> 
> 9f499b8 ("minmax: scsi: fix mis-use of 'clamp()' in sr.c")
> 
> to v6.6 and v6.10 kernel tree
> 
> Fixes : 74fac04ec2f4e413ef6b0c7800166f6438622183 
> 
> in stable tree("scsi: sr: Fix unintentional arithmetic wraparound")

Now queued up,t hanks

greg k-h

