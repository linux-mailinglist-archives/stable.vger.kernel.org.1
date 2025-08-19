Return-Path: <stable+bounces-171823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A45B2C9CE
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 18:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C371628F0
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB4F258CD0;
	Tue, 19 Aug 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="iJzSfImI"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75F1ADC93;
	Tue, 19 Aug 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621112; cv=none; b=N6O+rqPufRhftgUu+GUKHzMm928lHN35viuWUtmjk25owloFBZc/6OcAjcZU1PIKTOuWl9AcwNvFruFzzioFo727liNL7LZPQpnSUN4LprvIxgwNxyv7/os8nmt/aAB8KBCoP8DtiwJQl3C++XZ1ZvDSORXZlKk0W3pvCZ2nqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621112; c=relaxed/simple;
	bh=NN0nOKCF9tDY4KXQcL6EIDBie7fnelypVZIe+gEhhyw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbR/8BVSD/+B8Nr1HQX1lTg+acMoU8Si0/txescyl/aEUdpYW+iPprnYjSnHQG8X+9Df9l+VIXmhzb5HTQbvWY5OBjiZgZMeBY7oG6ksUIJHqDGmOKeXhX4GICZnuCrjbaXQkdoZUrfgGVpQEGKqUo/UGXp6Mfh/CLmtaRjTVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=iJzSfImI; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 19 Aug 2025 18:31:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1755621109;
	bh=NN0nOKCF9tDY4KXQcL6EIDBie7fnelypVZIe+gEhhyw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=iJzSfImIhwAhfXh9Y7Uek1Vwz2hp9PT7m5rDsz5iUkINuGcm6EAb/UpJ56X6FBUlp
	 gFARzZR85EUd4n1cm4c/lCNaEDE0R3Bix07m0PMhj9cCyU4CxiEyPn+A312zKppZyd
	 FtuUdX/aGE1hIK6URIGGAX9lXBowkvHVDOKSvWQihezIF3W2ePnjnL6NYaQCO9CEDb
	 Yq4tTin55K9h/MrY13r+8+4XnUmILzdzL2QtKcuLPkBiD1YruBf/VQPEU5UISSWsw0
	 jbfyejwlmMSxToaDZ4W1kztrDHGxgaPgrZOTfEfL0A7gW51ErIqO+DLzsiH865y/ao
	 NlrShfvcqnx7A==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
Message-ID: <20250819163149.GE2771@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819122844.483737955@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819122844.483737955@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.16.2 release.
> There are 564 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg

6.16.2-rc2 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).
No regressions observed, apart from the one already mentioned earlier
today for 6.16.2-rc1

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

