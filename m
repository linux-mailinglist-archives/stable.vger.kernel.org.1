Return-Path: <stable+bounces-177510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 906D7B40A6C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D17F1BA243D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F43126DC;
	Tue,  2 Sep 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="hUJHCqct"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683E2FF64C;
	Tue,  2 Sep 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830066; cv=none; b=gso4J/Ln+b2475g+5BqZm39XUCRKmYDX5FvCxzZdAMVkT9iCb5tyEi+JbD5NSZINITomOljtGgkdCe0yw7Ql9nmnr2/SAI1oa1wZX3KKiQx+f+fIqRwmAAN5wzuW8ckL5QZPjLfxRLiOm7mHaIjM1Z7T8LH2SHmy2LSK5xtQBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830066; c=relaxed/simple;
	bh=q77GAM8pG6xNg0BhbH5wutRCbGtXmaGnnhCYnxmxTYw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT7saYl42NzSMFF5R5Zvqko31zLhCmtJtDERDlA4qYW2noNhhpnF8PIk2toW3u147v+hGC8w0YxzQhQ18QKSxY9rZgT80Vfb/GVQLx6XCa8SbZGtYK6vRKn3IQf1lyG08sQTEa8WRD78D3LC3DGtZHu4lEZQ6bHsHMN6dxiexzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=hUJHCqct; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 2 Sep 2025 18:14:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1756829684;
	bh=q77GAM8pG6xNg0BhbH5wutRCbGtXmaGnnhCYnxmxTYw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=hUJHCqctVtVx1cX9oynYtki9q9b8HFSjfX+a9cuZ0RQ1bDyYlHbxilct356pOYrgK
	 QBQKjcNbQcATWhiblClcxDyOT7tmcjdxI/Fdhi5cnU4Ks+amzNbekZwBOmZj++Nw1T
	 +C7MqCgotPKFPBj1Y/XDP77fVhi1ZlpL57F5ehE3qbIUpGx39+GqdAScegdG/bgrea
	 Qx1UZTwytEQyep0tKx8lG4UDanTr6MKlIqiYuoHEwykmS9yIWa1VX1PluaT9p6MP5Z
	 9Qo5Mw5as0z9xn9ZFFG+qZpoU4qDWn8J2IkO8pQr96pGyUL5APASKE2nmq+Kuedypk
	 CCLihKbfBmwRg==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
Message-ID: <20250902161446.GG2771@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902131948.154194162@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg

6.16.5-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).

No regressions observed, apart from the one already mentioned for
6.16.2-rc1.
Thus I tested 6.16.5-rc1 with V3 of the patch and it seems to work ok:
https://lore.kernel.org/stable/20250821105806.1453833-1-wangzijie1@honor.com/

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

