Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7579C40B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 05:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjILDUp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbjILDTr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 23:19:47 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718AE10D3
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 19:51:42 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-573921661a6so3178799eaf.1
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 19:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694487102; x=1695091902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvq0d3FFjM2X6TGNOaKaPryHPOgfL8TG5xzRr6rjfq4=;
        b=CQTd8t5KTU3u+iqyfZqT+KUU5EzV1WqMtMWG52GQ2hU72z4Gl4NTWPne3osaCTtLwZ
         2dlTeDztA6Ox0u84xfuoxUCfRfsGPdKDFe3bs5HlyZ+zpM7mIaelaISRivKIIFXuRUpr
         xRiq3d5kQpT70jY9LLNjJNzgHMfVUue2phbT33+6hbiIDySCeOuW7Y2TSBl/rri7nMyb
         tNrg6sOGb3mcfc2bi4dKfMIz0FQDBcqXuEXOBqGutlY74r0r71z2cxWSILC09pl0E3XO
         Gj5wR2qNx7tOXZZjE3imd+AxTUau3/ECKHt0gm6ZXN+frNYjwzjDGMHdi8rCb1Mfmx2Y
         NfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694487102; x=1695091902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pvq0d3FFjM2X6TGNOaKaPryHPOgfL8TG5xzRr6rjfq4=;
        b=BcCpEoKxISP8WrrM+KcT9ieSE2bHvCghb7xUK7QgjSJcyefJ83hD7oY7tsCUCnKlAT
         TRl2X6feOCCc1Fj/1oymRBOvm8oV4u/NBrVR51U+ELRShU7WUnadChKXybrLM2w2MYHR
         9hjEEDeMQx7H/DJIAg4+onLVmTiWVswrn/lmJJgwnwCwj21U0/8AN9//GT2vATLkhlWg
         +wd/2H611ud4E05ig8iNuheiG1riuJaonkZZ1IHl5EEYwPQYzd1OLQjgD4dI9EKGBkHR
         0NVcbcTsn4CxzKcDpADSA2rfwlXPYAWwxEsmx7SmK8SbBfYzxIEUJTpWYJNKkTfS6sJR
         RRPQ==
X-Gm-Message-State: AOJu0YyGNc//NJaTFn3CTUKH7C1EMupy/506QWLPt4vojAs1V8PJ1Q3C
        CZvNptJXjN3b6Mn+TJIKWy20eje+ietWYq6G
X-Google-Smtp-Source: AGHT+IF3gOZTJZuhJ2iUPkhNyMYmhK2dON+TCsTPlkEu94l9+Gq5G7RflZHfa+lhZd7Fy0MTSujHog==
X-Received: by 2002:a05:6358:9887:b0:13c:c867:ee0f with SMTP id q7-20020a056358988700b0013cc867ee0fmr13683758rwa.1.1694487101561;
        Mon, 11 Sep 2023 19:51:41 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id z18-20020a056a001d9200b0068fbaea118esm3119614pfw.45.2023.09.11.19.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 19:51:41 -0700 (PDT)
Date:   Mon, 11 Sep 2023 19:51:38 -0700
From:   Kyle Zeng <zengyhkyle@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Subject: Re: wild pointer access in rsvp classifer in the Linux kernel <= v6.2
Message-ID: <ZP/SOqa0M3RvrVEF@westworld>
References: <CADW8OBtkAf+nGokhD9zCFcmiebL1SM8bJp_oo=pE02BknG9qnQ@mail.gmail.com>
 <2023090826-rabid-cabdriver-37d8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023090826-rabid-cabdriver-37d8@gregkh>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 08, 2023 at 07:17:12AM +0100, Greg KH wrote:
> Great, can you use 'git bisect' to track down the commit that fiexes
> this so we can add it to the stable trees?
Sorry for the late reply. I think the fix was to completely retire the
rsvp classifier and the commit is:

265b4da82dbf5df04bee5a5d46b7474b1aaf326a (net/sched: Retire rsvp classifier)

Regards,
Kyle Zeng
