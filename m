Return-Path: <stable+bounces-169608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F2B26D98
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 19:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D12B61083
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23116307496;
	Thu, 14 Aug 2025 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf1ashFG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA17306D3B;
	Thu, 14 Aug 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192164; cv=none; b=Xsjtbj69lbJF2DVmAltYHfwjniohl59hlxlKxMdhVZGm+372Vnb9vEJJfmDFgkoxlxaJsNgoOKXsE66k7Xq1toSpaqvZGiVBut4mIqY+8Tt4VlDavGVlltnpJKashIqykZTxJBM8kXW3Ef15zbbOP0Q1+bz8YlPLrRG5Z8UyzHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192164; c=relaxed/simple;
	bh=sqH9JkhU+X+akRNXh3sPhfcwCULCNtSZbkrYTgfbwdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB8Ls8CRFSVqxa9guHmS9cb31O7RFxx1xuFAZ8cZB4aOZjKMT0qb6pPVLxW/2fOh7F9GCCmMM6+g+6GUp+TTMybdq7TSgMttOaOe4GTmcHEOH8QeahjbDq56NpnhhK6YiA2QvXFH4ci0Y4GACP/tBGulS0it2dYApEmypBL6l04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf1ashFG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so1775951b3a.0;
        Thu, 14 Aug 2025 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755192163; x=1755796963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqH9JkhU+X+akRNXh3sPhfcwCULCNtSZbkrYTgfbwdE=;
        b=Hf1ashFGf8PQh5RsxXYBhaxMZDh570eM00p+/7LOoou65tSlwKa+FFbWLEPUc5ozyF
         HpVhi/mGKCbYO2HOOQ2UlCZbB0fdOxht/MXMwV7iHoXf5TIbjNGxU84Byg4N+nYWwwQk
         9ztDOQFWjISeX+awP9LMAVLkO550922PZTrd8wn/WegS0Zo3QD+OBOguJHQoSqgrFUF3
         2pODqYGgCLtbKBP6620tj3I5nD7bLODjU1PUAhJtabN13At9OveWDvpaMFVaABxdK3aH
         CFPz5QRNZiCNSfZ5rbWqexBAQ9bEpeKFT2YcLsh7AwbwgqnfLPHvTy5/pSZaFmhh1oLU
         QDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755192163; x=1755796963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqH9JkhU+X+akRNXh3sPhfcwCULCNtSZbkrYTgfbwdE=;
        b=KdHQtNqBjVzA8HfYl+IuQMLKO7j57jie2H7iWp04QZmF+E0S3BwFHpr77RX8LXMpny
         b/oF317Vn05rSySpsCLXt5P3I7MqQLExeWMJH17ePvVuIk+TvHQ1P48X0lRa3/iVM/Ik
         4GmWNiPb4yJp4muHq8U0lzNXY0ga9TYpbfMwmUK7hrLG2jCOBN1bhikz4yZ/QXD+4kEG
         0jeHV5WwAygCwxPSjQRUOrpTS4cqiY1vSdtfNWUiNPiatwrEQ73ju08lky8rHy1ww7/R
         utunB2dYybZb3RJgWcm6o98d9rQgiMqpqSwukMC2OCiYBT6HfDXqFlX0sTTpGOALzcn9
         EMbg==
X-Forwarded-Encrypted: i=1; AJvYcCWVRUbAnBBbAO+pX/fl/WtbC5RbCalfx3IeevwGrPnlbl7PANkcMWSJ5LRqz7vM1ncvZNma3lOKvos=@vger.kernel.org, AJvYcCXYd3mmW3t3+rByW+0ZVXZFortDlGJWOlbzBjCBWCQp09NSlsP2sTo7Kq/hgG03fyxX/RTTK/Mx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hm892J7z1SQUX0UOUDmmy4LARtJ+tsxDb65Wi9nQQwFFuElZ
	a2upsSUbT4YW6zXVSryuSywp/yx/nf9Y2S+4ZQhbkmH4pzcmPvdrLnAbg/0vUZC/
X-Gm-Gg: ASbGncuRXoUAxl3RX/XKsBbi2JvtPvg27Ki+34jEhRBJEzVuAW/HLncoHQvhvZjwDdT
	Be/6/eXUfLPD+UObJb6hIG+utH7fTwrjB2otu25EXf6KFHAEqQFGHt6Y/72QzLRpsflOBPX35GD
	O7ldSDlbx/ujG0KOsQyap6lKVnwvqP73p/7pm7yon6Hj3HHmrhnmCeLigqDvYKve9jFwdU2+kW4
	wxou1aE6fhKCkRP1HPJcjhqNnqKuHJMGrhZfdPvKlrgywYtOne9ZBGNgIFY8FB9NTXCYcyT0i4t
	rGElYHj2yAd+1VPXc9USE+xcfcO/ZysaQmu984vlaezmcXakWs+GTsPGvHGC1ypSHl/pthSh1LU
	MbPmwN5xI04BkB0M0IpozUa4QPHlDQFnISE5AcExdafNj+U//QIEQ
X-Google-Smtp-Source: AGHT+IHRX3+eLs8dwV3i7rR3nA85v65wdOU7CuP/9wFaucMkRWaf3WNrjZkCecvrg44u1LI1Bf1hnA==
X-Received: by 2002:a17:902:e751:b0:242:5f6c:6b4e with SMTP id d9443c01a7336-2445c38afd8mr51210775ad.7.1755192162458;
        Thu, 14 Aug 2025 10:22:42 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-244590608dbsm23779715ad.66.2025.08.14.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:22:42 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	usb-storage@lists.one-eyed-alien.net,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: Re: [usb-storage] Re: [PATCH] USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles
Date: Fri, 15 Aug 2025 01:22:35 +0800
Message-ID: <20250814172235.4353-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081428-unfold-shakily-6278@gregkh>
References: <2025081428-unfold-shakily-6278@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@Alan @Greg

Thank you so much, you saved us!!! T_T

