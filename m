Return-Path: <stable+bounces-19049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C469084C54C
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 07:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64953B243ED
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB71CD3B;
	Wed,  7 Feb 2024 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkOyU5/k"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7720319
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289091; cv=none; b=dwwf5RPxuCqIc0DuoI36EhZw5GMmrMmumbkDVoSjvWrxF4K6+/lfmU/Cdv9dd+CW9CDzKUFUGg8RVavyKCPrqqKV6WP0YawBRDtvsZ6G787qERLSAkgn20rDQrYjnx3TF2AazEPVV2a6DlQyFBElCtwPHkqOPst4QZPtCgfbAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289091; c=relaxed/simple;
	bh=46uArN+B/hsNLcWtiZW+AEINMcX4AYmkee1dzKOuIUg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JWc7stnVflbPZVl7dgeesHACDBLg7go39uiisC5p5zhSVB9B+S6dqxhECre6nEJM3y3paVoQn7Cv5P6JLPfWFow+Wj1sX0yGDA7Yn0/WNRL68pjxBC1nwL4K7d9NVuUviXJLBZEpn9yZHZlrpamqP+xLAL5mQ71yZGCUcf3fE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkOyU5/k; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7431e702dso3195025ad.1
        for <stable@vger.kernel.org>; Tue, 06 Feb 2024 22:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707289088; x=1707893888; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=46uArN+B/hsNLcWtiZW+AEINMcX4AYmkee1dzKOuIUg=;
        b=PkOyU5/kphziXV2slwSz6lRDp+zj3zeOWyKaTCS4rfsF/+Bowrval2a7+gl3qFMY42
         7p3H6uJD28tgYE2iFaK5zLLyhOr+xNLqZYUF21aWNRg/qjt4n0MCRQZck8xZc7PzR1sI
         AfWjn0Hglu6d6nYkY2qZ2yfO6EjtLwnMvasXMLuYCzI6TbrUzryXX/mgT1KT4f+90KtG
         3HP4YXKjSSxDUtRRO+LwnMnyPV2+budleeNTeDacEkbICLbbQ++/XgA5HbOzhlkFU4FY
         xNwxwdwPyWPysMMJ60OnfvO94ybXyllOgs3/llwiYjUNhHWQI9mHksWfsyz6HYh9Zi28
         McqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707289088; x=1707893888;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46uArN+B/hsNLcWtiZW+AEINMcX4AYmkee1dzKOuIUg=;
        b=Ph1Ug1jTIm+FU9iDXY+6uDO4tw0O6bXC8N7MzP4ul3f/wW0uUAjDt4N5sCmt38ymms
         r57Em+UPQOCvcAJWn44cdHPg/SCleLBdM1I+jlA2v7EKuhyihPjRQ/K5x1y2bExde4Hz
         Ba9HXAQUKZO+3fZI4uMcik7iMNTuVNmNZe4P24uKrPte8qfewIL/Be/jFYM2Bkq4jVmO
         46GwOpqMfF8C9cAmDaLehReJusBJTw7wqEJzKHsiUvh6DbVmhIe1yQ57EGYdAXftbnVn
         QTJKKF9AlBU+6E4yZ+vuFGDsaCCIoe/0apxK1WxjdTF1dJnlARQJ5U5NwUOuLpkJUfQM
         MNgg==
X-Gm-Message-State: AOJu0YyDejpprmtUOy3DluUtf0M7nne/w8x04Uwokga0+v3edfYd0NTg
	NOwJpm/QMXU+comeJggvihw4wq/rM3ikb3T1o/8sPeYdQHhsJCNBi1UcOW0s
X-Google-Smtp-Source: AGHT+IGOAQ74ZC5FWK9hS7+HSN0dafXqiEneyl+v8x0vRxWk/4KTMQsbpbuadQrVva750WkThlp4mQ==
X-Received: by 2002:a17:903:41c9:b0:1d9:e1e3:8639 with SMTP id u9-20020a17090341c900b001d9e1e38639mr4270165ple.62.1707289087811;
        Tue, 06 Feb 2024 22:58:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQABWU864uieLIpr0ZeoTbeSLmi31lpsW3ze56HPAupqAO7N5CZ/v6ZPHCqK1w0HhVvsc8aWpjcJcYut6u1SHi7A==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kh11-20020a170903064b00b001d94c01ae96sm667476plb.66.2024.02.06.22.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 22:58:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Feb 2024 22:58:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please apply commit b4909252da9b ("drivers: lkdtm: fix clang
 -Wformat warning") to v5.15.y
Message-ID: <b87dd10b-b8d9-417d-bea5-db5a5fc7d86a@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

please consider applying the following patch to v5.15.y to fix
a build error seen with various test builds (m68k:allmodconfig,
powerpc:allmodconfig, powerpc:ppc32_allmodconfig, and
xtensa:allmodconfig).

b4909252da9b ("drivers: lkdtm: fix clang -Wformat warning")

Thanks,
Guenter

