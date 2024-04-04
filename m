Return-Path: <stable+bounces-35884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF8897DB2
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 04:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040721C23617
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD5F1B59A;
	Thu,  4 Apr 2024 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ43a+NK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BC1BDE6;
	Thu,  4 Apr 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197542; cv=none; b=Hgf7BcUXFRvlXQgQ99zm5t3U+r2pm42OIq67mtTfe6jODADcx4e1xLV/vss8rFXUaz3OaGMpfVtqb5Sm4W/Y7i2OCOnXGQmjMW04TyrvcmZZh0eIHHDtOPGLkxrSohH4uNRv84KujMXSDC8u5m/MkIi3NJuPMJQriRqAv/aTMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197542; c=relaxed/simple;
	bh=3sZs4YtAawNjE2sX7XEh+m/dxbkSncLnlA85dWepu/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAaYR6SaVE4ItlOK7oHsu2rJwtqqHUYlpxXYu1NoTtCUblfXCRVlbnaZpaM3Uyg4NVQNaRJMGcsNnEipSym/tP5C8poflYx440Bhsc+/4IiO4W8MNwQJ5U47qZ12BjMRlyc9Qd1CtawDoS/YvcVrnlYdx92Y48nNRnVRIJyARJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ43a+NK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26268C433C7;
	Thu,  4 Apr 2024 02:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712197542;
	bh=3sZs4YtAawNjE2sX7XEh+m/dxbkSncLnlA85dWepu/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZ43a+NKtkAJtpdTqj0Tl0s+ZIRU3HBOqrMAbWcuj4oQ6EZ3l+QlUpS3z9YLxtMbS
	 vYoqCiiAtAs5u5XE6TFBqq/jXJrhbnxjRIGgiKIXNJrKnh3OBhFxheI+EeHHpTEyZD
	 xyJjNeaR2Kf3y299BZ+X4v2OKadJRcFkLo62XPn5g+wfD8e7KBcsT6+VYbIGk31Haz
	 CgKn5vcCcsZHxit79ZcgPjEN2OGLxilsBCMZytSED4ltUgfXEw25qFCYs/X2YJMp8k
	 7LyUGkvpcH9BJOJXdL7nzJ+FSE8jWhLVPu3Apie4N/jYmTGujDw3dD/qV6CfUKtsjQ
	 +eaMkfM7FJdKw==
Date: Wed, 3 Apr 2024 19:25:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] net: usb: qmi_wwan: add Lonsung U8300/U9300 product
 Update the net usb qmi_wwan driver to support Longsung U8300/U9300.
Message-ID: <20240403192541.1bbd7faa@kernel.org>
In-Reply-To: <20240402073627.1753526-1-coiaprant@gmail.com>
References: <20240402073627.1753526-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Apr 2024 00:36:27 -0700 Coia Prant wrote:
> Subject: [PATCH 2/2] 

We only received patch 2 is there patch 1? If not please resend with
the subject fixed. Please use ./scripts/get_maintainer.pl to find the
right people to CC.

