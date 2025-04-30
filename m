Return-Path: <stable+bounces-139187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E76AA4FE8
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2597BC9BE
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7E81BD9F0;
	Wed, 30 Apr 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="TMhTu9t/"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CB1B4145;
	Wed, 30 Apr 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025923; cv=none; b=A/Mt/WxV3FRKvncKda/qwpUUfFZ2OR07dFKUr6PkCYk8MAJ/5c7IddfPnmAygjsRR2Fg5DLiCzsYnQPkXNqN1GYOG4KAUY/LSVPiOKqRUkXzRZRgUAG2rdgCkATISy33MFpSUiWqvwc8getbWbaWqdx5aa3vAOPUenhAvIyqlbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025923; c=relaxed/simple;
	bh=9OYtP+tuv96TvJmDYlS/BAG1wZ0z4uLwKcle+HLREvI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaUr0tET6lXC0G+cR8q7YsbKx1u35EtvZ0YsWTQyjDSmO4C0zxs0xOVFbPQ8cShDF7r6fICWJkAztlWxKroY1N0sNDvbuUk00YdlwMJ6B+4savkRGeIzV21xMh6l3KRsWy4LYJampsgk1qYbyYPg+j2lusuUmGYrSXYXdEk4H/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=TMhTu9t/; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 30 Apr 2025 17:11:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1746025914;
	bh=9OYtP+tuv96TvJmDYlS/BAG1wZ0z4uLwKcle+HLREvI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=TMhTu9t/gzUjrieweKp34TzXu6yhhCeQSzbYphsPkyVoZpjKW7JR4e7sUGcH2zPGR
	 A0AX4i6cGmYx9KqGnnOgBDeIgiB9rOlC0GzhFEGcTdEK+iTHQ6Elm+EQJ1N9CDOaPU
	 +PINdod7DDVcLWKDEkymL3mDOZlNBNR7JveyCp6kGU1RgRLqVF3V2GSzdvjvzUwuSc
	 qKzTqu28qrmT+osp3yY0QmDWo4gUTxc/MC5+pQA3TMzJ6x6QmZKkj21qZP9Ubjibqp
	 1td/QH9qkh7/GyfpjdiwSFXiZGVxN+Oecuu23aQA/7LjtFmI/9dTOc1BY/MJvQnuJp
	 mo/0cNWm62Y/g==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/280] 6.12.26-rc1 review
Message-ID: <20250430151153.GA4298@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429161115.008747050@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.26 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.26-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

