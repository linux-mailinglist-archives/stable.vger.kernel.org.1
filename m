Return-Path: <stable+bounces-60091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E9C932D54
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036131C22329
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B047B19DFB3;
	Tue, 16 Jul 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DfXOSUeT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEA19AD5A;
	Tue, 16 Jul 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145826; cv=none; b=MzNmK9O/gLHG3W0jDXv2KSgoCjmzZB7j3/PfSEv7b74WjJmQHHVFs2zSr+rIXpt0bF0uABIWkiznvRnk8ABHSTqQ5d5sU3o7d720KkPXjFcyf27yXDtvqPLz7grTgKDZjh2porM0HlpHEo1qvRMddoq8JPE5nPU2pbGB/hce/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145826; c=relaxed/simple;
	bh=3A0j7N9+On0wvHFgJaXLdUqA78JO5t3GZ+IINDiCDes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM4udbT3L/I+kXJDtnLrKAfBlSmt8VLCdxqWviL8hbkeFv2/6KtZqY5h/7Wz2IBkAjO2SRd9CIdHMegCaDFXG52yip4d/hE6e+tsS/l2HTfEgASWBqSHbmFwwvi0TvkHqVn1gus8x6DpvLL/Q7QBVeZ8Uwx+uCxhHDaXFPbiUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DfXOSUeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59D4C116B1;
	Tue, 16 Jul 2024 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145826;
	bh=3A0j7N9+On0wvHFgJaXLdUqA78JO5t3GZ+IINDiCDes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfXOSUeTinK09bCAvCBe13hUMwLh89F2LAsBBpk3FINEwNOYPcnGFen1PBqs896n9
	 mKg5p7XcB/eoumW6i+pyJcT4vOtslLmwfrSF92tyupoHH3Rcnta2NdPUuSGednnQsa
	 T/VXp1LAe5zMUY4zI06h2+VCqP7tUJxdtpDJMqSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 6.6 098/121] misc: fastrpc: Avoid updating PD type for capability request
Date: Tue, 16 Jul 2024 17:32:40 +0200
Message-ID: <20240716152755.099332146@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

commit bfb6b07d2a30ffe98864d8cfc31fc00470063025 upstream.

When user is requesting for DSP capability, the process pd type is
getting updated to USER_PD which is incorrect as DSP will assume the
process which is making the request is a user PD and this will never
get updated back to the original value. The actual PD type should not
be updated for capability request and it should be serviced by the
respective PD on DSP side. Don't change process's PD type for DSP
capability request.

Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240628114501.14310-4-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1707,7 +1707,6 @@ static int fastrpc_get_info_from_dsp(str
 	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
 	args[1].length = dsp_attr_buf_len * sizeof(u32);
 	args[1].fd = -1;
-	fl->pd = USER_PD;
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
 				       FASTRPC_SCALARS(0, 1, 1), args);



