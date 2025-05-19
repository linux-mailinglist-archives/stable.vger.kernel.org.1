Return-Path: <stable+bounces-144875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A154EABC23D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBE6188D994
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA342853E2;
	Mon, 19 May 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkmnGYOK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062F3F9D2;
	Mon, 19 May 2025 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668133; cv=none; b=BySWp5zZfL+YucnJhM0GHh7JHC1Jvy94S9hGvWywIOEQR9+BqSAbZljcbFX69yoVfyca0PuYOwxgShCn51k/+WeWJpSK6KQvfprrVICFQHsLCj+pQSxfW+1257zk8aZpPwFaGZd77IzbfKRA14658QjlHVvaLRADomt/UvRHMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668133; c=relaxed/simple;
	bh=s9dzKebIdZy4b9g1q/MYH+pyp2xnRZ2ePgm1nnvc1FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hjd6nnlQ9m/cgpjnc15k1ZQM2uQfQbx/UAwE3Ck7KTNpYamcz0tejrk9z2bCE9gDOIqhInA082C7ST4fHvSkAeH1zSWNspGbxzjEcpscqVq7hZqzfSrZBjXVfJF7f4gWbi0wniEqc6MsKtc6BpKKPJRY7M73tyZ4TgVr3FWrcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkmnGYOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE869C4CEE4;
	Mon, 19 May 2025 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747668133;
	bh=s9dzKebIdZy4b9g1q/MYH+pyp2xnRZ2ePgm1nnvc1FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkmnGYOKI83Z98Kd1zCEKTEDbu8XrjAGeMJnSeRccWybQnf2T81+uewEttmwAi5J+
	 roGXHAtdCXeFi4HW+8VaHH//TQZUTv0p2ZHJ5JpOt0+icn104qKs8IHXSOfnEgg+T5
	 Nc4BX77308W6VWIVSXkTp5KdSNgVyVf1nzOvj9vvZQBgP/HVPyk02Tc5EVIJjohk1i
	 7z+7sxYZOaF29dbIS8JJWt5zwl6MgNbk+MxOl7qXPhnO+mV68W2wAZn685nOefHwIo
	 6abFYzFPw94Tsor4xCIzM2OOeNhOnt9zXtHU8NENjR7z3/ggg7avxqhE+r+xR5m6i+
	 djotxESeXZ0Mg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Add CMN S3 ACPI binding
Date: Mon, 19 May 2025 16:22:08 +0100
Message-Id: <174765431517.1659777.133438662977545374.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <7dafe147f186423020af49d7037552ee59c60e97.1747652164.git.robin.murphy@arm.com>
References: <7dafe147f186423020af49d7037552ee59c60e97.1747652164.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 19 May 2025 11:56:04 +0100, Robin Murphy wrote:
> An ACPI binding for CMN S3 was not yet finalised when the driver support
> was originally written, but v1.2 of DEN0093 "ACPI for Arm Components"
> has at last been published; support ACPI systems using the proper HID.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Add CMN S3 ACPI binding
      https://git.kernel.org/will/c/8c138a189f6d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

