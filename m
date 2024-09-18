Return-Path: <stable+bounces-76675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3597BD94
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 16:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B803B20F9D
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C718A6B5;
	Wed, 18 Sep 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3ixMTEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40289176230
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668175; cv=none; b=eUyI3k00/v93GgBUvrYTEH+Klc/Cb5cgb0k84K5WxvNjLud6GorPTP/MfkiBVu02+QxmwQ9qqMFhAoVRW/biJnTmPhuCbYU3aDRSCKstQh7QuVl1VD7b58qMM9nOHjdsNwtpM4xyYGWJRkmMzUyw6n9vDtzQ8R7npJvbQG9jMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668175; c=relaxed/simple;
	bh=e9ohwFdAeyYH4NF5cR4Pp3bNfLnaekedQlQKt/1NvQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rl3a5wX9E7wEvkdAg6W3IWn4srFo/uUEENOAFX2qxR+Vto8sLsX9+qfeoArh5IEyq1izNaJbGaGoG5dD1RjjcbH9GtpSslk7OSkWHJ7rHBlfQYI+zyyoolc2GQeXkZ1i2kRVGFv0JREtPvouaabjZ4cW/sgaE4iNSrPNtXxF5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3ixMTEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16070C4CEC3;
	Wed, 18 Sep 2024 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668175;
	bh=e9ohwFdAeyYH4NF5cR4Pp3bNfLnaekedQlQKt/1NvQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a3ixMTEjnEmEoYzEC6RxSP218t1L4bUvWK7JnZz+M+QsKuJNxQ7MQYhXTjVvHSYzM
	 OgkxpsVc8X2iBADBi1qWX1gWg4ElqW6kc0o/BdhN9Pd6E5vrtkDKDqWMXdI2WNyH1x
	 RVa/olqnWn1cleOAFDxpKzWBaGoTQS5wxoSlw0mt+pkCjVwRDOclOCCjGdnnbPz0gK
	 7HxHP3p0kH3GFoGWRTplsTMVADjzmpEgXG6NBwV/RkKGRZlk3EFVm5zBjsdSMRqqDM
	 wKeFcnEcJzkpmsy/QRR+SJDwVAITH3d5ViqDTHpBjLtTjuJa8sXU2SNbXbaF3jArVU
	 wLBlvwoYtj3gw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E69CCD191;
	Wed, 18 Sep 2024 14:02:55 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:02:50 +0800
Subject: [PATCH v6.6 1/4] file: add fd_raw cleanup class
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-6-6-y-v1-1-8731db3f4834@gmail.com>
References: <20240918-statx-stable-linux-6-6-y-v1-0-8731db3f4834@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-6-6-y-v1-0-8731db3f4834@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org, 
 Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=931;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=nh/hkFaW6sBtnLKjsDul7wXSyoueegBRVpblnjc9WjE=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t2MHMIJ5PmTSuk1NLOFRlkRruwsqG5O8fL00
 +YDMjuOEemJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurdjAAKCRCwMePKe/7Z
 bu3gD/wJ2uPhlSMSgJw3MNZm0VeGU3KfSqpxOsfnuIRZa7FPMDeZPez4VMGKXn99cM2PNzEujmt
 pMrvoDwg64javlJ3woiM7zhgXFJFvse6LaXOJFFarTCNDhYY+KFVXCWXBWbe/CVM+o1xaTiD9U9
 A26Hvz2JrvHz9kvXRZee44ipG+LNuPj1rffAMurtAWnZIj/WayxDgAxkHdeKYlgMsDcFRWjXHLr
 fMQtWJP8wToDttduyNXs9Nu2Jnvd7vr81Ry1hUCmS8UdYrBupj8XAfGbCm5jH2Id4jyD5oM8Bw/
 MlRCJRvxYpdUF48qvALEGLzsOcjJHqG5fPhc+G3VskK4fycGO46uVA1e7MaWOooubsLyUQnxRme
 +p8F0EFu80gc7R9NV3/OoEW7eBFpjc3UG8lDHD2lq+iVpg1yG38ajnziKN/lNxM+ED1tMa6uFaN
 da4bl/RHggZjcw56Xnk/O6wEkp2PS7Ibp/D66y0yePIwQeQxc7ze9Q0KO2fi0vlBt08Z5QM+Min
 2DLJh0ncHJS9eXBAQ0or+QRDeJ+PpsfSOQ92pfFoYSoz1QTG33CCj5oQB0D4O6WnTK+PcLJRVD1
 hPrHpE4dOyKZqXehLPWUWbv6UPE8KSxu/O8WwGThfmXAURsUF+psqia3pQol2T3XQ+ar5TI0xoA
 /k+nwCgtq+SFjDA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Christian Brauner <brauner@kernel.org>

commit a0fde7e upstream.

So we can also use CLASS(fd_raw, f)(fd) for codepaths where we allow
FMODE_PATH aka O_PATH file descriptors to be used.

Signed-off-by: Christian Brauner <brauner@kernel.org>

Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 include/linux/file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/file.h b/include/linux/file.h
index 6e9099d29343..963df2dc4f61 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -82,6 +82,7 @@ static inline void fdput_pos(struct fd f)
 }
 
 DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
+DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_raw(fd), int fd)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);

-- 
2.43.0



