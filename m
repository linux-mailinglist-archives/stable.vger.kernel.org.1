Return-Path: <stable+bounces-202998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42666CCC605
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D2753089B87
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BBA2C1597;
	Thu, 18 Dec 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g3SnUHkD"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD17283FEE
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070092; cv=none; b=Td2NIDt6oCnh0Sbx9kuoqPNE8fy5Dyi7QT/J3+ttqVTHPIXH9Tv/9EuCjhQ+S9k9ineXpikrvEX5lMgFGZbna3P218OULzh1C2u71uXpABsgmxgjJ6EDByvnTVZ3KQq1ULhOMipKYOAy3tV3efsPHUshz4Fjy+zlY6nQaSkURXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070092; c=relaxed/simple;
	bh=xuxYpHZyXgdRB12usLdOT6BuulW7JinEFCOoVCvBrAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grADvQKt1BxIqecJWjTmbJjqNpoh5PArCdDWsNrvQlp2AzIC/rgfwaR6GCLxHNsAi+n8VuFDVWaijVcXNptQQU835JqNDZDu7nvGIDS6x+4665c/iqd5SCJi3EBLHXRoP6RSVKraLu/mAW5iIuWzicvBsz0be2/gIJbGYWy23do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g3SnUHkD; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-450be85b7d9so441486b6e.0
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 07:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766070089; x=1766674889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkCfuBffdvy1ahpgO4ryU5C0fH+X3z2hQTwZhDTxw+o=;
        b=g3SnUHkDciTxN12qlWxzvZUkmedWYbBO69JzHDDwudvobB1qIx72cgggsuycg8yu98
         PabIvLqOgca+y+McDIMCelU4Uh3cr3gH0tOsxFhy01WUQrK8OelEnAjfLNaI27ee6myc
         fyDZz5ASJpBkAfT7tdDlDW2IzVNFk1X11UaV332+G8kRsQwtKkuaxn57ZC+W/WP5ek9+
         s6nbbxMjVBnqV0VBwNm2ab1bDxwaHh/lvSOzhTIfVafRZTq6uFANDuGq/bGx+7MiiXiQ
         w3sd/XQ89aihs1AdBKDbbhwT1SQ3EMKCvx53s9W6wfZ4p3DGzO6vEh87cUO1XEEcc8oq
         qVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070089; x=1766674889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fkCfuBffdvy1ahpgO4ryU5C0fH+X3z2hQTwZhDTxw+o=;
        b=Z14oDw+OGwo6TfGRSqGasu+afp6aZr4EsZciYtQrQ+XqBUBkQaqLoSqn3mDdQlrb/h
         ZmlkkgI5Og1UVAcK0UQfqO6P3Sh0PtNyj/zHIGrK9Y0mhHvctMbiD9yVVzGN6vBPRNwy
         CLBr/dVXX9ZjkfgXnqWurFY810ONhGrOlQ0y+eJwz024Zq/J2XpO0Nv1kk9u6xa2+0YW
         coRo9dZBOjAaY/rES8SSC6HxUpYdpB5GyrNSe0XcRNmTpoOHxPHZ2Cf7YoTxPYVG/6xG
         W7SNo4R+kSyLxpysRof0FYAGbWeOP6l4pAkmNSnyv6dhrwrMT6cgFZaXdJbgdUWIwtfs
         6Kfg==
X-Forwarded-Encrypted: i=1; AJvYcCX07OI1yBQ8ZcaCwm/cq+PGLXfBYss5JoMMfTtrAWMKTwH6/7MO21ZBiD6nYOdlb5kEFNez5Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCDB0HKf82fMSSNRWHDe+RxCeRY+9bR1a8hM9o1JnsD5H6X4fF
	hlgq4zZQGtuyyaxFXzDaDR2rkbVJxuxZ6SQlIDBDft5v7J37dYFeIIm9JBOSio6jNgY=
X-Gm-Gg: AY/fxX68OF8Ehjylqe1tJ9AZV9vBljF4LZR/e2DZDUSV/bAeCfl69BWQj1EesLkEDZI
	4xVhA9IoXfTT72UZeq3wETpwOyhLS5pMvDvvtwGE0uFBvgWclIZtY3fvr/Ru+JFTE/f+QYopqrH
	x5FYlHGR/MTrX1PwFp4sX/vG8FclEE7GTp9nQOyCEhwQXuuA+/fK+fWWq5KEhJ7aol5zv+pHI0c
	vrkFZYqnj91fYAXP2eEWgWpP9LtMlt01vB5qvEg8Q6Z1qWaK/JkaYyODfv71CMsvArLRK6muKkt
	BFOx+ZDC2en6oTaj1ZSycRp7u4Lc6Yr76Frw4UpOpk4vBJPVg1h5h7ObAeYBwNxrV2A5jHTfpCv
	86fiyG9W9ikwbXL6UxHseqQamGx333Vmqvr2ImO/Cm97AxNBKGSjD2MassKIRhz3I/N+Qig==
X-Google-Smtp-Source: AGHT+IHNqQEyO2+zm0WZX6kMf8tMyinPk4DY7+372q7upiugrQB8KXle70xpWHUfWtjzKhWHklipKw==
X-Received: by 2002:a05:6808:c291:b0:453:746a:c61c with SMTP id 5614622812f47-455aca2f25amr9904875b6e.66.1766070088843;
        Thu, 18 Dec 2025 07:01:28 -0800 (PST)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457a42fe963sm1327816b6e.1.2025.12.18.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:01:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org,
	Julian Orth <ju.orth@gmail.com>
Subject: [PATCH 2/2] af_unix: only post SO_INQ cmsg for non-error case
Date: Thu, 18 Dec 2025 07:59:14 -0700
Message-ID: <20251218150114.250048-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218150114.250048-1-axboe@kernel.dk>
References: <20251218150114.250048-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As is done for TCP sockets, don't post an SCM_INQ cmsg for an error
case. Only post them for the non-error case, which is when
unix_stream_read_generic will return >= 0.

Cc: stable@vger.kernel.org
Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
Reported-by: Julian Orth <ju.orth@gmail.com>
Link: https://github.com/axboe/liburing/issues/1509
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 110d716087b5..72dc5d5bcac8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3091,7 +3091,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		scm_recv_unix(sock, msg, &scm, flags);
 
 		do_cmsg = READ_ONCE(u->recvmsg_inq);
-		if (do_cmsg || msg->msg_get_inq) {
+		if ((do_cmsg || msg->msg_get_inq) && (copied ?: err) >= 0) {
 			msg->msg_inq = READ_ONCE(u->inq_len);
 			if (do_cmsg)
 				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
-- 
2.51.0


