Return-Path: <stable+bounces-179743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE710B59D6B
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 18:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5A1887167
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CC431FEED;
	Tue, 16 Sep 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOz71tG/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE831FEF9
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039743; cv=none; b=AqfMp+WthFfgIxKhFGF8Jw//pSpwqWyIxi60eWpQpGZ3pY5IMliRChFIJ3+9yamV+NFGqAA14oIOBJfb6E39g1QZsz2iel30lBeUVpaZDI8nM1Fan+SVDKrYu9koHZDvsTRqWx5pGXwRosUPu2WjL6wFAyamBbOgNvACK0+ngKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039743; c=relaxed/simple;
	bh=gK359pvYrO3WDD2oYBkE6FVYGp7Ggifr5YVhI6RIAEg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hCUZDPXOAtpjJOoMhxTLoPFxS2yefy+x1eOF4efCmGuffDbGbk6nkMoUuxw/ag5TmRmLDZMlTvEqtL3nEXgTIKp/SjZb35QCE6nnGaGU+8H3PFHtcZKitRUUpfAGtbuTT3S/Gz9fyvdO/TR2zUAgT3UWFtqbMUftRsNuapIH0Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rOz71tG/; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea3f2bf7b34so2270112276.3
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758039738; x=1758644538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NuoFnFSraKtRXBhxtKLY2karNh6HqKKq/kD04WKwiRU=;
        b=rOz71tG/16gyZ/tYZlljzGbnCDA+ftZwvghFNQIOQjDnhk8d2dAlugBg9ptLXETsmQ
         n8Y13vBcDCB5jFuQyj8glMFRXF0Mzr1bKGyKC+IhGQm4Sx8LxdXP88HUrZuxJT1XQuKN
         MHAcFKGeC5fuki/InVDk7Sh1NynUst7v6UfAIUvpHJ2CUi8iIQ1L0N0yB8N0GHu+3xIn
         Civccxz4lEnvthoM6cgi8CONzXAHltZtZrqK2r8tQ3pVp/gPNqkJkHLGkz6LrG5N7SNT
         UM90DAuEflrvFx+FZXmULdXMw294ptc63ho84rGk2SPWHNpGOG2sPDUTAgfg9rEf5m4I
         Za8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039738; x=1758644538;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuoFnFSraKtRXBhxtKLY2karNh6HqKKq/kD04WKwiRU=;
        b=WT2b6rO6LBPmbmeZ/U93QK+yDFdw09cjbc2YEX+tyXp4Ph6erPQrb4QhTAh/FGtWfj
         P9yy3JpRrF6DrnJ3uF00Cv9sso0qDLr2tM+RS9LEWmsJfUl4vxRgJn14P96mMnaZRsy1
         ddwjWTPha6gWUAqfz+EYCI3Bl2wX9RS2Nml/9DO/zsapXe/YRnJZfKfzXZyeScrDBLIR
         lygq1G0Fj/iuC1RiPqTGkNUoMf6hCe7KICU4xItnuFiuk8QWK1g4cIj4R0Ps311gIsLB
         orTYhS5XGDoDxTVJWgX1M2QVFOl8g6LF3S89w/LneCeLLKViK8+nmAk3BJ8EEmrbhTwQ
         XtNg==
X-Gm-Message-State: AOJu0YxIw90Z8gJCJd7TQHDZIxWm5zoCcmJyJMVYBc+K3pjYoOXd0+Dh
	6JVhEcYt3N958g3jQQf4vJkLIp00lXXLnxnh9fT4pwszf3FOlpGY3TQqsfhWrYI0T7Bv6iQlMbj
	Elbpi+y/2pHaMKbDhOkZDW7DVQaAAk5DfRXHV9zUaq+yR8xRXqQxqVuzE3Q==
X-Gm-Gg: ASbGnctbygciyEqKAHJyo3VwWZs1Ct2NNoCtYn9f9J/XDbO8o/qE5xlEZqzCru5WO35
	H3rpBtjDIlQ1ss12qZcd7ooGz5EQsUI9DXIH79bcoPeiMe/S+iXg6Kgy9+kCP9DGrW6jvCabRzs
	ksgy7fEpgGIp9YX6li3BVIcot3MxleAMc4ZuDgj9h+9Jln0qVe3/Byk5m+9dm8pKEZH8hWdjnRk
	6ffHynX2tOKF5W45HnglmwxmZF+cMUdN4GAPnctn6M7O1CBEe7wahUBG8x7XMgk1752lD7xpY0Q
	JVJjgpVTzu6FUSnWSAqeSLNpWHMVh4tUTUlgrgtC7zYYEd+wI2iPaD/RtxeGfXYDy6Ru0wE7ohS
	bpybN9A==
X-Google-Smtp-Source: AGHT+IGqiugDgpOfKL72CEp3P4txwNfZ5Ocmpt3KC/PWSRjevPf41KWH5s/zbQu3Kba+QpFHQ3dCPmxrVkzINgWLV+g=
X-Received: by 2002:a05:6902:1b8d:b0:ea5:cff:8f63 with SMTP id
 3f1490d57ef6-ea50cff9679mr3687767276.48.1758039738041; Tue, 16 Sep 2025
 09:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Wed, 17 Sep 2025 00:22:07 +0800
X-Gm-Features: AS18NWCPS26_DvimZBQq88oGxc4AAGfFQyy7zkUI59_Ct-XemJlstEOEG7RHNqU
Message-ID: <CAMSo37UP50E6gAeP9bRmcJ2af9v+kNU4DJxrrZcsLEzM0PY7OQ@mail.gmail.com>
Subject: Please help to cherry-pick 25daf9af0ac1 ("soc: qcom: mdt_loader: Deal
 with zero e_shentsize") for the 5.4/5.0/5.15/6.1 versions
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Amit Pundir <amit.pundir@linaro.org>, John Stultz <jstultz@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi, All

Please help to cherry-pick the following commit
    25daf9af0ac1 ("soc: qcom: mdt_loader: Deal with zero e_shentsize")
into the following branches:
    linux-5.4.y
    linux-5.10.y
    linux-5.15.y
    linux-6.1.y
Which is to fix the issue caused by the following commit in the
branches already:
    9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past
the ELF header")

Just please note, for the linux-6.1.y branch the following commit
needs to be cherry-picked first:
    9f35ab0e53cc ("soc: qcom: mdt_loader: Fix error return values in
mdt_header_valid()")
before the cherry-pick of the 25daf9af0ac1 commit.
# if this needs to be in a separate cherry-pick request
# please let me know.


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

