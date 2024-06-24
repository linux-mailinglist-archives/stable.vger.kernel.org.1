Return-Path: <stable+bounces-55097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3BA9155CE
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 19:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE351C22CB4
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A044F1A00EE;
	Mon, 24 Jun 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0fooTTD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DAF19F47C;
	Mon, 24 Jun 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251381; cv=none; b=OKx6lZtAVvDk/T71/V1/annMpI+OPSn89vgAOVG49hhPV7LiXqTdkJKFBUAaqwGwzbqKdmglMhgGFSRdlKEln6bI7tJrbr2dggWq9ZtBp9JCPJ0rOiDUhb3A09GjVamj88dgppKWVgNuSXYZ+oHZxZpJrMFAnQUuZwZ+R/DdSVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251381; c=relaxed/simple;
	bh=HnJDmZnTD3YrBwWRBPe4nGHrCgYX8JZA6v4BHCSztKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSPO0cNLgsnkXpfGcdOo5+3xaUYb982To1cej5ZmB49NnQ+oSfSSay+T7UM91ckkaFugXuGy5o1AbMU6xI1zggkvbq+thf3FPGtx4hSDr/HExQeATG7cRhYq4XUrRyPJvgOroJwQyB9/y7qoY75y/TUuVaboczqjXjlFzHrpG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0fooTTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7A6C4AF09;
	Mon, 24 Jun 2024 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719251381;
	bh=HnJDmZnTD3YrBwWRBPe4nGHrCgYX8JZA6v4BHCSztKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0fooTTD+n2DN+nhh3DD3hpyHZWZNrkZ19yZqWeveqO14Rvrm46yzNppnbHOQgjPy
	 gCbRcL75ixVJIjtaZ+fhXRz77lz7GSCk96VTBLHvQWuHIG1KnesqRwYcR9OTLzjpOM
	 uU9jCZ1F/hhNEUV9TxkLuA68/LQZevmBh6YKS8R1NdBgdym98b5JBgrdj9b6XApyZc
	 bBOCreVeVKRc8rynOWSwLJKL8gxs2TnV4JnO1rwGyoT86E31hZvS9JO3qLaLN2oBPT
	 CnfKlNpZ9CFNdxIdyzoWfv7cWW7MfCvkDxBF7CfkAJ5Qs48bhgj+3J8v7WoDzIQoTI
	 RKcwa/1+0BZRw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kan.liang@linux.intel.com
Cc: "Khalil, Amiri" <amiri.khalil@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2] perf stat: Fix the hard-coded metrics calculation on the hybrid
Date: Mon, 24 Jun 2024 10:49:37 -0700
Message-ID: <171925132143.1926204.4446895102202800571.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240606180316.4122904-1-kan.liang@linux.intel.com>
References: <20240606180316.4122904-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 06 Jun 2024 11:03:16 -0700, kan.liang@linux.intel.com wrote:

> The hard-coded metrics is wrongly calculated on the hybrid machine.
> 
> $ perf stat -e cycles,instructions -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>         18,205,487      cpu_atom/cycles/
>          9,733,603      cpu_core/cycles/
>          9,423,111      cpu_atom/instructions/     #  0.52  insn per cycle
>          4,268,965      cpu_core/instructions/     #  0.23  insn per cycle
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

