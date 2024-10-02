Return-Path: <stable+bounces-79873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D6A98DAB4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B39F1C20E46
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214F61D0BBA;
	Wed,  2 Oct 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vU+PDfIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F901CF7D4;
	Wed,  2 Oct 2024 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878716; cv=none; b=f9AF6X7Rk275ezWcEGh7VVRbYAbeWzGSza+ZDPYXBjRLzMVjzYg9BXa5b669bDxCGk/S12v3t2VvHTVWTFVMtJs58SUk1NE3r46OKZ/XcmzA12DwZK5MFRZadq2sXinDUPjiYu55Y3eVkjVVqZUJIW3letAuvl3s/CQlCtPNX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878716; c=relaxed/simple;
	bh=bqeF2W6+KAfUUBh60F9Qi8r45KhEgFjEU6xYtmLM7/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3oQTQud3NKmbM3IJoxlin+VTnYu+waxSdqiSr72adsKkSwc+XQCY9+9kuCLMqAPNMtvKh1ygy56h18ZOQF4QbqKN6upLRK5jrkcjpRIlikVJg49j14hfG/sOqBFWK9F50ZHFpefH83l/ldLXovbgrlDTh3Y8FuoTKymG91ZvAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vU+PDfIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FF1C4CEC2;
	Wed,  2 Oct 2024 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878716;
	bh=bqeF2W6+KAfUUBh60F9Qi8r45KhEgFjEU6xYtmLM7/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vU+PDfIFLqWh0itWGL7Hom4Z/Zhch2jBIhjh9fbgaXcoWtbXhDtxz42hUqKFFp7xF
	 57oXiGSG5XFVosdzhZ5qKxQnXqvZh84EDSeIFaYEqWEFVHfncttGRGTjUmuzYQYKy7
	 uutzrcsDg6cg/Ar14KSFXTUE4Q619w9+9wHGzy5M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Roman Smirnov <r.smirnov@omp.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.10 478/634] Revert "media: tuners: fix error return code of hybrid_tuner_request_state()"
Date: Wed,  2 Oct 2024 14:59:38 +0200
Message-ID: <20241002125829.973190410@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Smirnov <r.smirnov@omp.ru>

commit e25cc4be4616fcf5689622b3226d648aab253cdb upstream.

This reverts commit b9302fa7ed979e84b454e4ca92192cf485a4ed41.

As Fedor Pchelkin pointed out, this commit violates the
convention of using the macro return value, which causes errors.
For example, in functions tda18271_attach(), xc5000_attach(),
simple_tuner_attach().

Link: https://lore.kernel.org/linux-media/20240424202031.syigrtrtipbq5f2l@fpc/
Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/tuners/tuner-i2c.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/media/tuners/tuner-i2c.h
+++ b/drivers/media/tuners/tuner-i2c.h
@@ -133,10 +133,8 @@ static inline int tuner_i2c_xfer_send_re
 	}								\
 	if (0 == __ret) {						\
 		state = kzalloc(sizeof(type), GFP_KERNEL);		\
-		if (!state) {						\
-			__ret = -ENOMEM;				\
+		if (NULL == state)					\
 			goto __fail;					\
-		}							\
 		state->i2c_props.addr = i2caddr;			\
 		state->i2c_props.adap = i2cadap;			\
 		state->i2c_props.name = devname;			\



