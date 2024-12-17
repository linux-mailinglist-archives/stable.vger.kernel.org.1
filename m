Return-Path: <stable+bounces-105061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C9E9F5771
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CC3188F20A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973471F76DF;
	Tue, 17 Dec 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSuipB6x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694D170822;
	Tue, 17 Dec 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466577; cv=none; b=KVx9WMSzUh1w4cFSbAx1kDR9QJLxx7FJHsvjjryxTUNrLjYiaEB0cG7PW/GHXTj+JjmOK6z69SRxs3qMo8ApILPQC/hsgNZrt/7CIQmFhkIcldLsIrBxYiJ4/ogBMQmC3mJvHti1CSM/j+hnxd7gGgea+x6OU/Ydc+7TQYeoLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466577; c=relaxed/simple;
	bh=hLnPIEKOGpSD1woPg4dqhaXDe/GqQUAN1jPeBvp6i6c=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=lM8aq43o9J10o3sFWq2kfmCN1fh+dqwclMguYEVTtePePzUabI8a47MFXjvp0PMmsuiB5g0fH4TW6kiE+eSWz94Sl+4dyWKtF3KUteIgRG3JHhlvRvk8LCQokd2shPN20QOcPyidR/fXX6sj5UNeExXqA//QEM+tTre3lispqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSuipB6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFCAC4CED3;
	Tue, 17 Dec 2024 20:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734466576;
	bh=hLnPIEKOGpSD1woPg4dqhaXDe/GqQUAN1jPeBvp6i6c=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=QSuipB6xBm5J2bIalVSnyKaZAfqIkDB5+zc1RT/QeaCe0gHiz5nacGEEsj9DnN4My
	 QdF7ATUBLQ/DciEmJOF0yUOQElVhYLYAOP7D1SB7gktAdWc6OFaZscY2nhDzf6FC9H
	 n0I7zpONKAhbc0oGYOqnidWtcTdXQX1MjdO+ysTTVCu9xqILzbFYJloezju2IBncjP
	 DGwK/BIuhgg+mDxnMY/HQZK68DTSfRTuCiN2/ntdamHVJtOgy7v+3IQJC1FyWI3XdK
	 P+7iD53Ma0RSX22im9AqUnMo9mFFalxo0cnkTd1/4qVhFyvH//4Rv9K+tXRKlvsje1
	 uWiDzhjmgvSIQ==
Message-ID: <6e302efdddee29149a324562ea2b9972.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a07584d803af57b9ce4b5df5e122c09bf5a56ac9.1734300668.git.daniel@makrotopia.org>
References: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org> <a07584d803af57b9ce4b5df5e122c09bf5a56ac9.1734300668.git.daniel@makrotopia.org>
Subject: Re: [PATCH 2/5] clk: mediatek: mt2701-aud: fix conversion to mtk_clk_simple_probe
From: Stephen Boyd <sboyd@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frank-w@public-files.de>, Geert Uytterhoeven <geert+renesas@glider.be>, John Crispin <john@phrozen.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Miles Chen <miles.chen@mediatek.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Date: Tue, 17 Dec 2024 12:16:13 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Daniel Golle (2024-12-15 14:14:11)
> Some of the audio subsystem clocks defined in clk-mt2701.h aren't
> actually used by the driver. This broke conversion to
> mtk_clk_simple_probe which expects that the highest possible clk id is
> defined by the ARRAY_SIZE.
>=20
> Add additional dummy clocks to fill the gaps and remain compatible with
> the existing DT bindings.
>=20
> Fixes: 0f69a423c458 ("clk: mediatek: Switch to mtk_clk_simple_probe() whe=
re possible")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied to clk-next

