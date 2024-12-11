Return-Path: <stable+bounces-100556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B09EC6CF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A313166506
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67BB1C233E;
	Wed, 11 Dec 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="myOl4Ozr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759171C5CD6
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904976; cv=none; b=GsS3pI9YJTLep8uENaVnhdzNQfq92Fa/hSI8FDUwGXTMh4i4x7DI0l0oI9LblEMyS30s5dgRu1Q1XOXjEXG1ntbswcDu7xFUtFf9RiLAP/b1Df5NVDqC+X0YUushEt5mfQqD64dgykC671jczMz4pfLj6nypefSvlF6lpvttepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904976; c=relaxed/simple;
	bh=an7iqeXHdH7hUGa+Z87ocGSk6O4AoNzmytwg4xYKlR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuGJpjCN1nhDMvt+hTPYIRazF6rOYvLeJ0cEBjTfv1In8gTwt7XGagzBC/07xnptYT5Lr6acsXWLjf9K6lu2YSpsakCHMCPTdNRZtdVTYeWR47SGQUu+s0V1DPuSEb4u7zPX9qzjygZYrSapwpISbsu9RFjnTw2gwPCeLsQKto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=myOl4Ozr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCF7C4CED2;
	Wed, 11 Dec 2024 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904976;
	bh=an7iqeXHdH7hUGa+Z87ocGSk6O4AoNzmytwg4xYKlR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myOl4OzrkVUROgeQqCNsxkOaU4xUbLMArHbPeYqbIt9g6BeoF4v3HfOTZYOLkIe2+
	 UnqaPWGTTnph9DFUV64LKlZH2uUE6G5UFTMF0vVNv5SmR4+3SgqYcJBm3Bms/qs0FG
	 ZStph+9dR7OetI+5gdQOfLJNJKkumtsLWUK8i4OI=
Date: Wed, 11 Dec 2024 09:15:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: wayne.lin@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in
 is_dsc_need_re_compute
Message-ID: <2024121136-snowfield-camisole-8ed9@gregkh>
References: <20241206100629.1243468-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206100629.1243468-1-jianqi.ren.cn@windriver.com>

On Fri, Dec 06, 2024 at 06:06:29PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Wayne Lin <wayne.lin@amd.com>
> 
> [ Upstream commit fcf6a49d79923a234844b8efe830a61f3f0584e4 ]

Please cc: all relevant people on backports.

