Return-Path: <stable+bounces-152518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF61AD6591
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022512C0F8E
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5181E9B28;
	Thu, 12 Jun 2025 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoHMDTzi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA41E0E1A
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694972; cv=none; b=TNVWZ3fIQI3MVzRWLk/RPFgGub0OEW5+xBj8AyYpI8/kUsDmb/d04U2vEy5ulN1cQWW+YUE5NfgOMMl18ibKr8cuwAB2ERfcmEu5uAgmxb6JuqzxSzZicd89Dlv9DgFR6A7+NFxJoPhIOSeb0P1FD+eottUYGF1P15RLZY2qaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694972; c=relaxed/simple;
	bh=Wb7nn7wPlnLihTIGZUZ9V+8AV0PPOMY3O4U9LhGSI4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry87UQdV6tGQ2RIRDPvVy9VpfqIq8UUM69cSwysBpSemOL5Z1MmB+tF0x1vDwMjea+zZeLFP3Qc5O2DmLJsg8RKQmBF1ntpLxO4Z5hGFCuFYtyujjY29TqHKTOxzhxCHESdLNcIFjLLPFEyqtylTZcsbMhEBThmnmRjfwv9mVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoHMDTzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717D7C4CEE3;
	Thu, 12 Jun 2025 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694971;
	bh=Wb7nn7wPlnLihTIGZUZ9V+8AV0PPOMY3O4U9LhGSI4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZoHMDTziztIe2Vj64eaIZEL0xxriupK72KlFfg3tqwBqAIddB4s2a/3ZdP/LWkI8B
	 BDZ2ANTcOLDCEtMjI1uQ0wNRYIdTgZetu4QeCgOXviLTgYrGy9w0NHSAv8z0SEf1u+
	 TQ+TJDRaKmUGkJNrhhvl6Nlqeo7yH899Nd8xEe7lpO0t8o4/gpgWkTjfEx/HUfTnhY
	 BpluEZaPorxaQElbyBP5wB8Dns0GF5SO+lXqGdK2DVjUPJBTztugCIf3KW/qymaH6b
	 35TR9S/KTVJidBJY6lQVZMrSIeRMy6XykIcaR0pdmEZ5A43FsNV7ReB1lVkgkksyNz
	 24b40aJa33IgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 11 Jun 2025 22:22:50 -0400
Message-Id: <20250611103934-61f9dcfae1f44faf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050517.582880-4-claudiu.beznea.uj@bp.renesas.com>
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

The upstream commit SHA1 provided is correct: 5f1017069933489add0c08659673443c9905659e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Claudiu<claudiu.beznea@tuxon.dev>
Commit author: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5f10170699334 ! 1:  f1ffc6f977237 serial: sh-sci: Clean sci_ports[0] after at earlycon exit
    @@ Metadata
      ## Commit message ##
         serial: sh-sci: Clean sci_ports[0] after at earlycon exit
     
    +    commit 5f1017069933489add0c08659673443c9905659e upstream.
    +
         The early_console_setup() function initializes sci_ports[0].port with an
         object of type struct uart_port obtained from the struct earlycon_device
         passed as an argument to early_console_setup().
    @@ Commit message
         Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
         Link: https://lore.kernel.org/r/20250116182249.3828577-5-claudiu.beznea.uj@bp.renesas.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
     
      ## drivers/tty/serial/sh-sci.c ##
     @@ drivers/tty/serial/sh-sci.c: static struct sci_port sci_ports[SCI_NPORTS];
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

