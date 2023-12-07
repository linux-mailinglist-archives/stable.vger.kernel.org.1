Return-Path: <stable+bounces-4887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C0807D8A
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 02:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197F91C211DB
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F20E7F2;
	Thu,  7 Dec 2023 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgXklL5D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B8DEE;
	Wed,  6 Dec 2023 17:02:49 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so274116a12.0;
        Wed, 06 Dec 2023 17:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701910968; x=1702515768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0ZHx2dTpeeD/dzT9UX8bmnVSTh3P7Zoy3W1EjS6Yvs=;
        b=PgXklL5DfrY+z2Sojg4K0GhWAcv8yGpLesQA9JLBMLz8FL9iINIhDv5m/zih91q0Ul
         buasSlbpFsKmM0sjOpImIvsqkhu6JdGtgUY3HYHvYsmGxGULNFI9LPq7l4ZJsrGj+PGi
         Gkx7cbQc8snT+K1NbjWi7eYEEd6L13rkHIGrdmCZNBCyBSvvYSxwizZ4b6FZ5lGQtO6q
         sd12Z2uwcsdUx0iE33sxFEEmNtx72M5k2aHDIKPPVqR0KKIkWjh9a8IMyjcvWj+r1cex
         UkZT22jxmit3LpaQhw81vgnTp3xUOSN1fa+MNs2p9QTKDgjl3839LcaTPGe/VS5z13E7
         X0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701910968; x=1702515768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0ZHx2dTpeeD/dzT9UX8bmnVSTh3P7Zoy3W1EjS6Yvs=;
        b=jbclxm5/S1Pq2pSzYd5NSwdBCOjJ42ux2yVVoTlT6CvXHSvsCIyqv0XW1ZuzDAXXs4
         y6Z2JzWpcGnoScWb6joQNbMBbKXGi7oLZvpqjHyd6iSBhfN+JLFTvhoFORh5yCim53m+
         StFpgf6TjNjqNUM1G4iTPSzWoBzzQEoOqljaiLRWL0YOw4VHPPSrFO/EeL6wtODm04Zt
         h5xx74d8L5ECxWADtQdeD8iOuFIo26PgoHwHh3Kp8YRkzlK1w2YSsLUo+Ldtt0WmoHew
         h6r4Ua952o3I6LFb7RYH4GiiPDg7XsHI63rdmoXB/4l+0hfnfEW3LGzNi2W8/58sS/gt
         c6CA==
X-Gm-Message-State: AOJu0Yy2Hq26IGayBDIJEePGIB84cg2enyWxGOYJpOZBV3ERThCGYDDB
	xR2E+YbcsVb4AWV9XNATU3U=
X-Google-Smtp-Source: AGHT+IF0NVXLnlslRkPt5reTco4DlgSrpI8lg5XgES8+5VA48tmxLztqsza/95Hxskb1PbsMxiLgzQ==
X-Received: by 2002:a05:6a20:9410:b0:18f:97c:825e with SMTP id hl16-20020a056a20941000b0018f097c825emr1268601pzb.104.1701910968337;
        Wed, 06 Dec 2023 17:02:48 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fa37-20020a056a002d2500b006ce93ff8c7esm127179pfb.104.2023.12.06.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:02:47 -0800 (PST)
Date: Thu, 7 Dec 2023 09:02:43 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Florent Revest <revest@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] team: Fix use-after-free when an option instance
 allocation fails
Message-ID: <ZXEZs2rOUil8QH8Y@Laptop-X1>
References: <20231206123719.1963153-1-revest@chromium.org>
 <ZXCNouKlBlAKgll9@Laptop-X1>
 <CABRcYmKK0F1F5SzXoUpG4etDz2eGhJoSZo56PHq7M+MNjcjTKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABRcYmKK0F1F5SzXoUpG4etDz2eGhJoSZo56PHq7M+MNjcjTKA@mail.gmail.com>

On Wed, Dec 06, 2023 at 05:31:58PM +0100, Florent Revest wrote:
> Thank you for the quick reviews Hangbin & Jiri, I appreciate! :)
> 
> I just realized I forgot to CC stable (like I always do... :) maybe I
> should tattoo it on my arm) Let me know if you'd like a v2 adding:
> 
> Cc: stable@vger.kernel.org

I think Greg will take care of it. No need to send v2 when there is
nothing to change.

Thanks
Hangbin

