Return-Path: <stable+bounces-107806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B4A038E6
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EC91885D08
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909F1E0090;
	Tue,  7 Jan 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K7iamkj3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E1B156F3F
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235526; cv=none; b=Qypuso+eFQO2VO1HpL4xzwk31uA1Z6OmwjyR1Xv/KharMfboq64rXewSLU6hoqQBaj3VsnxAMhfN5sTYGEbhJjADt9GLPaAwyTdvJDq5MjwlEUBzdctwclzn5gJN36jp3sWOweyIvM2t8vubpIwN5IR2XwlEZA2qg6fWyNm4FKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235526; c=relaxed/simple;
	bh=eVJmQfqk+wa5AZU0IhCkNx/9MfMPryn71yEHOV3FSII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj8ye94nFB23GfldxNdhWhOpJBGMoc02FjuW58z34DFCBdC5vMXnhclMVOaoWdAUVHGaB5hGhTxTn2K58xbcEI0WfjveepW5NiGVYlwDJ39SCEfYrjhIBKFoB3G0VTknRKWg/Y1Tu6c88IYKf+0gIjwv96JcyahUCNtxQofwuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K7iamkj3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163dc5155fso218062175ad.0
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 23:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736235522; x=1736840322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6TpyBIBHhRqCq2NSRZgwqe9hlCBkCrXXo96kF987tg=;
        b=K7iamkj3gTXDw0vIgQVPISht3cQa2rah3gmhdGA9ZPZohcNgMyCQ5xu8U+EuNwMWVn
         fpLvRRXifggqtG1Bat2LoIR2yhnwj8wxQwdWZ1FVCzBrCeU06AMFDcGZQ3idL9uEXi1C
         HNgigDZfT2eqbzg3XDHysb4ftyfzKTvATAesM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736235522; x=1736840322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6TpyBIBHhRqCq2NSRZgwqe9hlCBkCrXXo96kF987tg=;
        b=Ee69ryqmNYYUTBFrcqC1HrpbiNC9DhSpQQOAgXI0OUyw7RFPsv7ISVGb6Tt+0b6dcp
         /qu41ee//EYnJCwSO2vroVsw3WQvcHLVoUQxdwoY9x0oPATPrdRn+lxWxIkHsQIc5bU1
         bXtWyMqjYum4cRg1XFQ9vp6zfNk10FL650hw4L4FonIKJQR6yf6R8apinTxz59ao5izZ
         ej/md0KItqizC4A4Ptz3u9CGgdQQyWzgk9/n+F/7CJ6yoK9CPXNubP/IFEUpTFGXbFCW
         PFsklRqDtpG4om63EItIawM2QPWqSWI+1d3iAl03hUAn0stVJJbfOOh1Gd+OH0K19NM5
         XtVw==
X-Forwarded-Encrypted: i=1; AJvYcCXCQtew0wsEPbSrNjr4EqB/3l7+XxWAvzv7f76d+OwDwQwFCBXsXgR/CgEpLsogVUn35HbRzkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtIg4yNUZRmn0D4j+We1inty0NcgOuNTdSThuN2YJgcxOKHvK
	BpKM4QJF/qp/9gquWXIAFLaMymtybjiFQTAzwpNDelURSGmErNut4b2qTw74ew==
X-Gm-Gg: ASbGncsEyBl3ldfjvPih2IYO98lCWojltXMBCr2DZYrkaqwjFBq90D83xibYCK5a9qZ
	viJFodD1Ar8Vc4QZWqn+xcC0QGkaq72n9UWFLjMr5mVskzS8kVOMEvjTK2NcH8T02KX6Hx+dkmT
	NNTfDk4b4FGRbwhBPosoIPlerr3yGVNC2NAEz8e9QqW334mJT9mpIF4yH1iTwxFz9ZA0iGIELBu
	l3v3DZcz0J9sepLM0viGqADRGiRTbsj/4KDTEkG84+EhS1qQPZXCkAQV3P4
X-Google-Smtp-Source: AGHT+IFP9fBz3XVX9qDbkVrQfLxKKg2cGiqLB8JwvWr59yDGayoZBFKqHGqMHDY/d4+jdwiBBRO7JQ==
X-Received: by 2002:a05:6a21:33aa:b0:1e5:a0d8:5a33 with SMTP id adf61e73a8af0-1e5e048adb9mr95188628637.18.1736235521892;
        Mon, 06 Jan 2025 23:38:41 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c142:c1e8:32c2:942a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad81582asm32720364b3a.9.2025.01.06.23.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 23:38:41 -0800 (PST)
Date: Tue, 7 Jan 2025 16:38:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix potential UAF of zram table
Message-ID: <sbdzv6z5sixmj7fr3jmjwxqce3tbbzvshbb7qgumio4jdahn24@jvvadmtindgs>
References: <20250107065446.86928-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107065446.86928-1-ryncsn@gmail.com>

On (25/01/07 14:54), Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> If zram_meta_alloc failed early, it frees allocated zram->table without
> setting it NULL. Which will potentially cause zram_meta_free to access
> the table if user reset an failed and uninitialized device.
> 
> Fixes: 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by:  Sergey Senozhatsky <senozhatsky@chromium.org>

