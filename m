Return-Path: <stable+bounces-152513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829FDAD6599
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101923AE15C
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115A21E503C;
	Thu, 12 Jun 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7FoYtOG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA41E5205
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694962; cv=none; b=smpv4zcG8VoGzVd6NNnpX2Payk8UcgMU34u0ImG6qvfZUd8Uz2seMw08utE88H36Ft0dq/fWkPe4uNNYq8ctgCWpIWlZc7L0qXaGtIhv6khkqdnyMugHLXoxBXSbLZNCW9YZgi+gWCuKWgjdbNV4WnRqcT8YZjVVDIDtELK9PEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694962; c=relaxed/simple;
	bh=JcQ6MSRmf02g/elDkl7uNdr63eze+ni18hwfxo3zy+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r54DjFvaEN8a8G26u9fes8lhGlgm5mLAz4O2vVtVPO3F94p/sqAmhu/Mc8tRf8fUrBKUiiUJdsfdxVJ5moZQy01WYZtQFYUsqqjVS1uajOzXW7wnPBA/6JkQmaqkwfi2J/LGpaH4HOwT/jrTV0bh/7qiZDOl8/THlsCW+VfupUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7FoYtOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A37C4CEE3;
	Thu, 12 Jun 2025 02:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694962;
	bh=JcQ6MSRmf02g/elDkl7uNdr63eze+ni18hwfxo3zy+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7FoYtOGX4kQ/ZlpVtC+wgtVAjIcRnUAmpkyOS3EsJAQsb4Ij5ylHIFKhkTmU62En
	 NvaqenX8rhzMgYoajNqZCVkg8otL1Uwt0k/qs+dhIfZEe9oirmh9/2JcfLMVNgGo3V
	 N9crh2noR2e7ZUugDaXHRHIpGfdwB4Ak4Zi4k7qo69CfiCPlSmw/bNI/zGx9GTdPcB
	 pP9pTdD3S7aK64T3Qs4NqAClRGYq7ZXo+GDk30kTl2ppeTUrJxnaMGl3zJi1xCf0Ve
	 5lcrD1Z3YzIw5W9NDww3CjUVdQOsHthspNfOOwfXGUfpLkn7XUaUS+fUtjEiE2PSpk
	 9YXgzjs3kQgDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 5.10.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 11 Jun 2025 22:22:40 -0400
Message-Id: <20250611111141-0aea1cb1ee33533c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050053.454338-5-claudiu.beznea.uj@bp.renesas.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Claudiu<claudiu.beznea@tuxon.dev>
Commit author: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  651dee03696e1 ! 1:  f821d4cb79a00 serial: sh-sci: Increment the runtime usage counter for the earlycon device
    @@ Metadata
      ## Commit message ##
         serial: sh-sci: Increment the runtime usage counter for the earlycon device
     
    +    commit 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f upstream.
    +
         In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
         with earlycon mapped at index zero.
     
    @@ Commit message
         Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
         Link: https://lore.kernel.org/r/20250116182249.3828577-6-claudiu.beznea.uj@bp.renesas.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
     
      ## drivers/tty/serial/sh-sci.c ##
     @@ drivers/tty/serial/sh-sci.c: static int sci_probe_single(struct platform_device *dev,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

