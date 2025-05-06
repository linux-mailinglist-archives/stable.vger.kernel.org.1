Return-Path: <stable+bounces-141856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8638AACDAA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 21:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF9503EDE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 19:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71DB142E86;
	Tue,  6 May 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Xei9OplX"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC1179A7;
	Tue,  6 May 2025 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558159; cv=none; b=SzaahI+dhU5Ty+9LOgNmW7/TfftTlfA3qY1ZjEx3Z5PSSBWSGzRvD132xUBHSOiguM7xBJCqe5BctnqJPbbkKUHq4rCePh2ZzS4NPIIxy0khI7wA9B8gsYvkVmcqNtT7/9NobcFgXAvDMdoDznD3D4T45nZqippaZIKIyJWSkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558159; c=relaxed/simple;
	bh=PswShjgN6Rszgz9uyGjrC76Ws2kV3BczGDl7Z32YkD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrqhJ66/b7AfX/OgrALsSA0JOP457i9EaSBH1+cBgHtBYBeyLXh/cgpdtMUuEiGxlQJmIgIEjnWES8IQdWAqtkmkFL5dpaLuEwNDBZk2djX2WjDcRw90L1+hAdwhoLrfwjjjj/0ACB7kEIu5s621pN5hlI5VKQYe2ggXJUf52NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Xei9OplX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bDTAGv7oRiMJeLUnclRB63EHqXZhIX5RyFl4xNg4aaA=; b=Xei9OplXgWfccuSLrRkj3fR8qH
	wMLAUlTYWHm/JllhBzwLEGWWOkE86zc0G0dB0aZDahq2PD3lH5zlrwVOCfqTkpJJqPVOLjfAaHC6P
	qOYqZjVYXD7np/5D0sqDqkgMra1gJ16Ppqa177iusR2zf2t4AKcXqE4QT/p0EbYuTxBevM/A+Za4r
	KffhzqVVl13US1ZPfgdL5ptQe6MAVoiARLA9uewTn1INOnNy7mQ04tbdozEJhoHa+o4lEUoyPR89Q
	Jas6z/BcAASjCYctn0GcaGnZCt7F25UJs1QDDlknyqFLsPJM30WzmJNpq4jsbJQp7gHJPT5edm7hv
	Uu3TEQAg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uCNYa-0052Yu-Ri; Tue, 06 May 2025 19:02:21 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 3BE19BE2DE0; Tue, 06 May 2025 21:02:20 +0200 (CEST)
Date: Tue, 6 May 2025 21:02:20 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Pasi Kallinen <paxed@alt.org>, 1104796@bugs.debian.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	Debian Bug Tracking System <submit@bugs.debian.org>
Subject: perf r5101c4 counter regression
Message-ID: <aBpcvG2yBtrrTie-@eldamar.lan>
References: <174654831962.2704.6099474499200154093.reportbug@deveel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174654831962.2704.6099474499200154093.reportbug@deveel>
X-Debian-User: carnil

Hi,

Pasi Kallinen reported in Debian a regression with perf r5101c4
counter, initially it was found in
https://github.com/rr-debugger/rr/issues/3949 but said to be a kernel
problem.

On Tue, May 06, 2025 at 07:18:39PM +0300, Pasi Kallinen wrote:
> Package: src:linux
> Version: 6.12.25-1
> Severity: normal
> X-Debbugs-Cc: debian-amd64@lists.debian.org, paxed@alt.org
> User: debian-amd64@lists.debian.org
> Usertags: amd64
> 
> Dear Maintainer,
> 
> perf stat -e r5101c4 true
> 
> reports "not supported".
> 
> The counters worked in kernel 6.11.10.
> 
> I first noticed this not working when updating to 6.12.22.
> Booting back to 6.11.10, the counters work correctly.

Does this ring a bell?

Would you be able to bisect the changes to identify where the
behaviour changed?

Regards,
Salvatore

