Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B77D888E
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjJZSws (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjJZSws (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 14:52:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77311AD
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 11:52:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27d425a2dd0so1042816a91.2
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google; t=1698346363; x=1698951163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3el8K7l4KhSfOh7Yq5Ci32FysUQLtgWxtCBTApe7bRI=;
        b=ZYP3ZBefHBIWq0gwuH/s4GV+NIu5HbdVNedrPnEbNJrfl22tWKn7+9itIxnOykOgBI
         5lru6z5KBjG1Rv9iSeQ6/6duVdte6t5vRjaauq1/w+rk4bJFrZNeVUbJ/YekChh4FGJH
         pbPGPRvVnwEn7nRHENRt5BE7Pi7+nhP6Z2BWgqlkT7HGbpyC6b8UvMsGiO3fyLHJ9hT2
         dIY7+P9UX8wxk5KSIuVjev3MTfiBhesFkMesIlqgEkFmKV9pyJoWhApnzVhtSYhx/GG8
         3I/qOGMa6K7WodeRalJyxntmyAmGF/hLH0fJRMds0FzfUFsTgXWlIDBXjTvF5EM3k8NC
         CpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698346363; x=1698951163;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3el8K7l4KhSfOh7Yq5Ci32FysUQLtgWxtCBTApe7bRI=;
        b=GqSU/WfFHEmKSLBbYkNjIRSh1XX/QB/XhTJmmThXTD4fkq7XURqKXlRHtWpGTePqg5
         Oh0nccmsXCJfApLQdWx81hDAmF0R2/ccNcBpt/KkfRpRlmN1s4Nbe0N/Jt6PKKcosW/A
         yJztfszfBj9R2nEmy4zPDrIqWAd9cbP5U2d3ODXdLaM+HromyejQvg4nag/F6c3Ya5dt
         Vt/Qk5YKNTRDh8eO7ITtDJMG4xKTqEzPUwFz7tmwt77kGk99oreDWEK8WgOl2pa7lcxm
         5IOCfflca5Sh+rQIeqzKn9q/Q0DIDf7DiUxztuXMb8+SPT4OpTQSUYgDHxULuUZEsSpI
         FHvA==
X-Gm-Message-State: AOJu0YwGJduzU+h3ceO3FLsM91Tgsi7L+/mUL9vNQtaQ4nnsV7Rw7790
        6YHhgh2Tmk5wxm5Y266JQvFGXUG51VR1YCENegrnvw==
X-Google-Smtp-Source: AGHT+IHMyLz/O9mIstfEUzlFO6V+kzmAteEEKojn1pFAGUXXd/4x9PgPtTfqdgya/2WMjzl0tc9RqAwPf5Mdx/2wxn8=
X-Received: by 2002:a17:90a:f2d4:b0:27c:f845:3e3f with SMTP id
 gt20-20020a17090af2d400b0027cf8453e3fmr448846pjb.1.1698346363180; Thu, 26 Oct
 2023 11:52:43 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Black <daniel@mariadb.org>
Date:   Fri, 27 Oct 2023 05:52:32 +1100
Message-ID: <CABVffEPthUzEHS4xCdYWMvjSK8EjjqVzsekxEuMaB_j2or1QOw@mail.gmail.com>
Subject: Re: [PATCH] sched: psi: fix unprivileged polling against cgroups
To:     hannes@cmpxchg.org
Cc:     bluca@debian.org, cerasuolodomenico@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        stable@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Thank you,

Reported-by: Daniel Black <daniel@mariadb.org>
