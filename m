Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE726F32FD
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjEAPgq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 11:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjEAPgq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 11:36:46 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2215118B
        for <stable@vger.kernel.org>; Mon,  1 May 2023 08:36:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-74df47ad36eso115466985a.0
        for <stable@vger.kernel.org>; Mon, 01 May 2023 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682955404; x=1685547404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwS3WoU0ckMhXsmcicgFgMs5sLzKP3mV/eAYcwWxFQM=;
        b=c5Vr+zY1BWMyMoW0XQqKO0Ia64iiC7/f3p85YQq6xtxQupYimnTGElHoARjb8PsPBL
         NbCpDjcygKRoWzQ3khvNU/t+fs+UPmnZvTG/wPL/uc80U+0/fAcNlYGYxVaY+PsQol50
         kRhL4QBMO8oARXfcqGrduAelAvBffVaVWklN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682955404; x=1685547404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwS3WoU0ckMhXsmcicgFgMs5sLzKP3mV/eAYcwWxFQM=;
        b=Cisw8WFI1ygKbV7vaORjgSqjc3aBhlG6KfRVsHW+TXwreLh3kppnBMneV1WgD8UP6Z
         Olc9jPxLoEIWYjnugznV7H+vTn3RUXmj1T5d8n1y212IMNiLaXgXCiZNboQ6i9qyL+yK
         7rmdJ43NXCRqo06RX/Yyd3Y1Zn2SYFeCF7ct5IbfDxC8Tnx9y++MzDNqJRkjetVzEbYr
         FnryUFja/JFXkCnBaieha1BmQmhR3zI3YWCyNQFTx4dgobh3MUGZamgfQu50t5wAvUJ2
         rvPOkYfhXkToIk/6s5lR5E1WUo4bgb3Dawp4qY69pgHVW4eF7NCQiSAKizRQovdfxZks
         4z4A==
X-Gm-Message-State: AC+VfDwrsgqmU/+kV0jOZWDWPVA6Bm1o8noZnMCE0aTKi/Hi33nleIwZ
        6kqm3pj5+dbCevxunbBgAW9FeQ==
X-Google-Smtp-Source: ACHHUZ5wScQOXjrB9UG54hL/GjOi0OmwOvQWTGT/JUN3Mfw+YHr2cHXyYdTrglUUS11YgjqDkbsLIg==
X-Received: by 2002:a05:622a:1c2:b0:3f2:ca6:1817 with SMTP id t2-20020a05622a01c200b003f20ca61817mr11371033qtw.50.1682955404207;
        Mon, 01 May 2023 08:36:44 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-132.dsl.bell.ca. [209.226.106.132])
        by smtp.gmail.com with ESMTPSA id he31-20020a05622a601f00b003e635f80e72sm9505598qtb.48.2023.05.01.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:36:43 -0700 (PDT)
Date:   Mon, 1 May 2023 11:36:41 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        tools@linux.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: Re: [ANNOUNCE] New script that finds partially-backported patchsets
Message-ID: <20230501-deskwork-imprison-fc8451@meerkat>
References: <20230430064948.GA36600@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230430064948.GA36600@sol.localdomain>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Apr 29, 2023 at 11:49:48PM -0700, Eric Biggers wrote:
> - `find-orig-patch`: Finds the original patch email from a git commit.
>    It first checks for a matching "Message-Id:" or "Link:" from the git commit.
>    If that fails, it falls back to a search of https://lore.kernel.org by
>    commit title and uses some heuristics to try to find the right patch email.

You should also try matching by patch-id. E.g., taking the commit from the
example:

    $ git show de534c1cb031 | git patch-id --stable
    7d23fb78b4bb892155827a612631168cb28584cc de534c1cb0313a070f45938a53b53927cd34e5b9

Then we can search by patchid:7d23fb78b4bb892155827a612631168cb28584cc:

    https://lore.kernel.org/all/?q=patchid%3A7d23fb78b4bb892155827a612631168cb28584cc

-K
